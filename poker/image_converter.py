import time
import os
import subprocess


class ImageConverter(object):
    def __init__(self, images_dir):
        self.start_time = time.time() # TODO: use this to check latest image
        self.images_dir = images_dir
        self.image_path = None

    def get_image_path(self):
        latest_image = None
        latest_time = None
        for image_path in os.listdir(self.images_dir):
            full_image_path = os.path.join(self.images_dir, image_path)

            # ignore if not image
            if ".jpg" != os.path.splitext(full_image_path)[1].lower():
                continue

            image_time = time.ctime(os.path.getmtime(full_image_path))
            if not latest_time or latest_time < image_time:
                latest_time = image_time
                latest_image = full_image_path
        self.image_path = latest_image

    def get_payout(self, tesseract_path):
        self.get_image_path()
        image_name = os.path.splitext(os.path.split(self.image_path)[1])[0]
        output_path = os.path.join(self.images_dir, image_name)
        subprocess.call([tesseract_path, self.image_path, output_path])
        return output_path