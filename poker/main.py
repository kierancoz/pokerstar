from image_converter import ImageConverter
import time
import subprocess
import argparse

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--compiled", dest="compiled", default=True, help="compiled")
    return parser.parse_args()

def main():
    start_time = time.time()
    args = get_args()
    if args.compiled:
        subprocess.call(["../../autohotkey/autohotkey.exe", "getGameInfo.ahk", "../pokerstar-control/images"]) # not working
    else:
        subprocess.call(['getGameInfo.exe'])
    print("Test")
    image_converter = ImageConverter()

if __name__ == "__main__":
    main()