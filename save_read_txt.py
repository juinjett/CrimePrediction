
def save_to_txt(train_datas):
    f = open('save_train_datas.txt', 'w')
    for train_data in train_datas:
        for data in train_data:
            f.write(str(data)+' ')
        f.write('\n')
    f.close()

def read_from_txt(path):
    return 0
