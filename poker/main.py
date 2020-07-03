from image_converter import ImageConverter
import os
from datetime import datetime
import argparse

def get_work_dir():
    # checks input work dir
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", dest="work_dir", help="working directory")
    args = parser.parse_args()

    # if no input work_dir, creates one
    if not args.work_dir:
        args.work_dir = os.path.join(os.environ['TEMP'], "PokerRunner")
        if not os.path.exists(args.work_dir):
            os.mkdir(args.work_dir)

    # creates unique directory
    guid = datetime.now().strftime("%m-%d-%Y_%H-%M-%S")
    unique_folder_path = os.path.join(args.work_dir, guid)
    os.mkdir(unique_folder_path)

    return unique_folder_path

def main():
    work_dir = get_work_dir()
    image_converter = ImageConverter(work_dir)
    print(image_converter.temp)

if __name__ == "__main__":
    main()