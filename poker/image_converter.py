

class ImageConverter(object):
    def __init__(self, work_dir):
        self.work_dir_ = work_dir

    @property
    def temp(self):
        return self.work_dir_
