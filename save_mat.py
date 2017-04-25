import scipy.io as scio
import numpy as np
def save_to_mat(data,path):
    # dataNew = 'dataNew.mat'
    # data=np.array([1,2,3])
    scio.savemat(path, {'A': data})

def load_from_mat(path):
    # path = 'dataNew.mat'
    data = scio.loadmat(path)
    print data['A']
