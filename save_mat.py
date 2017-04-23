import scipy.io as scio
import numpy as np
def save(data,path):
    # dataNew = 'dataNew.mat'
    # data=np.array([1,2,3])
    scio.savemat(path, {'A': data})

def load(path):
    # path = 'dataNew.mat'
    data = scio.loadmat(path)
    print data['A']
load(1);
