#works on pandas 2.1.1, numpy 1.25.2, matplotlib 3.8.0 and scipy 1.11.2
import pandas as pd
import numpy as np
import numpy.linalg as la
import matplotlib.pyplot as plt
from scipy.stats import chi2

data1 = pd.read_table("XFGvolsurf01.dat", header=None)
data2 = pd.read_table("XFGvolsurf02.dat", header=None)
data3 = pd.read_table("XFGvolsurf03.dat", header=None)
data1 = data1.iloc[:,0:6]
data2 = data2.iloc[:,0:6]
data3 = data3.iloc[:,0:6]

S1 = np.cov(data1, rowvar=False) * 1e+05
S2 = np.cov(data2, rowvar=False) * 1e+05
S3 = np.cov(data3, rowvar=False) * 1e+05

S = np.vstack((S1, S2, S3))

A = S.reshape(3, 6, 6)
n = np.array([253, 253, 253])
N = n - 1

preB = 1e-10
maxit = 15
preQ = 1e-10
maxiter = 10
p = A.shape[2]
k = A.shape[0]
B = np.eye(p)
f = 0
zeroes = np.zeros(3)

while True:
    f += 1
    Bold = np.copy(B)
    j = 0
    while j < p:
        m = 0
        while m < j:
            Bmj = np.column_stack((B[:, m], B[:, j]))
            T = np.zeros((k,2,2))
            T[0, :, :] = np.dot(Bmj.T, np.dot(A[0, :, :], Bmj))
            T[1, :, :] = np.dot(Bmj.T, np.dot(A[1, :, :], Bmj))
            T[2, :, :] = np.dot(Bmj.T, np.dot(A[2, :, :], Bmj))
            Q = np.array([[1,0], [0,1]])
            g = 0
            while True:
                g += 1
                Qold = np.copy(Q)
                Delta1 = np.multiply(np.tile(Q, (3,1,1)) , np.multiply(T,  np.tile(Q, (3,1,1))))
                Delta = np.zeros((3, 2, 1))
                Delta[0, :, :] = np.diag(Delta1[0, :, :]).reshape(2, 1)
                Delta[1, :, :] = np.diag(Delta1[1, :, :]).reshape(2, 1)
                Delta[2, :, :] = np.diag(Delta1[2, :, :]).reshape(2, 1)
                a = Delta[0, :, :]
                b = Delta[1, :, :]
                c = Delta[2, :, :]
                abc = np.column_stack((a, b, c))
                abcd = abc.T
                d = N * (abcd[:, 0] - abcd[:, 1]) / (abcd[:, 0] * abcd[:, 1])
                Tsum1 = np.zeros((k, 2, 2))
                Tsum1[0, :, :] = d[0] * T[0, :, :]
                Tsum1[1, :, :] = d[1] * T[1, :, :]
                Tsum1[2, :, :] = d[2] * T[2, :, :]
                f_val = np.sum(Tsum1[:, 0, :].T[0, :])
                g_val = np.sum(Tsum1[:, 0, :].T[1, :])
                h_val = np.sum(Tsum1[:, 1, :].T[0, :])
                y_val = np.sum(Tsum1[:, 1, :].T[1, :])
                Tsum = np.array([[f_val, g_val], [h_val, y_val]])
                e = la.eig(Tsum)
                Q = e[1]
                maxim = np.max(np.abs(Q - Qold))
                if maxim < preQ or g > maxiter:
                    break
            J = np.eye(p)
            J[m, m] = Q[0, 0]
            J[m, j] = Q[0, 1]
            J[j, m] = Q[1, 0]
            J[j, j] = Q[1, 1]
            B = np.dot(B, J)
            m += 1
            print(m)
        j += 1
    maximum = np.max(np.abs(B - Bold))
    if maximum < preB or f > maxit:
        break

lambda1 = np.multiply(np.tile(B.T,(3,1,1)), np.multiply(A,  np.tile(B, (3,1,1))))
lambda_ = np.zeros((3, p, 1))
lambda_[0, :, :] = np.diag(lambda1[0, :, :]).reshape(p, 1)
lambda_[1, :, :] = np.diag(lambda1[1, :, :]).reshape(p, 1)
lambda_[2, :, :] = np.diag(lambda1[2, :, :]).reshape(p, 1)
a1b1c1 = np.column_stack((lambda_[0, :, :], lambda_[1, :, :], lambda_[2, :, :]))

u = np.vstack((a1b1c1.T, B))
us = u.T
us = us[np.argsort(us[:,0]),:]
uss = us[::-1,:]
B = uss[:, (k):(k + p)].T
BB = B[:, 0:k].T

fig, ax = plt.subplots(figsize=(8,6))
ax.plot(BB[0,:], c='black', lw=6)
ax.plot(BB[1,:], c='blue', lw=4)
ax.plot(BB[2,:], c='red', lw=2)

ax.set_xlabel('moneyness')
ax.set_ylabel('loading')
ax.set_title('PCP for CPCA, 3 eigenvectors')
ax.set_ylim([-1, 1])
plt.show()

V = np.zeros((k,p,p))
V[0,:,:] = uss[:,0] * np.eye(p)
V[1,:,:] = uss[:,1] * np.eye(p)
V[2,:,:] = uss[:,2] * np.eye(p)
psi = np.zeros((k,p,p))
psi[0,:,:] = np.dot(B, np.dot(V[0,:,:], B.T))
psi[1,:,:] = np.dot(B, np.dot(V[1,:,:], B.T))
psi[2,:,:] = np.dot(B, np.dot(V[2,:,:], B.T))

de = np.array([la.det(psi[0,:,:]), la.det(psi[1,:,:]), la.det(psi[2,:,:])])
det = np.array([la.det(A[0,:,:]), la.det(A[1,:,:]), la.det(A[2,:,:])])
test = 2 * np.log(np.dot(N, (de/det)))

df = 1/2 * (k - 1) * p * (p - 1)
t = 1 - chi2.cdf(test, df)
print('p-value:',t)
