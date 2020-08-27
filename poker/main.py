from image_converter import ImageConverter
import subprocess
import argparse
import os


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--compiled", dest="compiled", default="True", help="compiled")

    # if not compiled, these args are required too:
    parser.add_argument("--images-dir", dest="images_dir", default="../images", help="Images directory")
    parser.add_argument("--tesseract", dest="tesseract", default="../tp/Tesseract-OCR/tesseract.exe", help="Tesseract path")
    parser.add_argument("--autohotkey-exe", dest="autohotkey", default=None, help="AutoHotKey exe directory")

    # Not used right now
    parser.add_argument("--target-name", dest="target_name", default="getGameInfo", help="Target name")

    return parser.parse_args()

def main():
    args = get_args()
    image_converter = ImageConverter(args.images_dir)
    
    if args.compiled == "True":
        subprocess.call([args.target_name + ".exe", args.images_dir])
    else:
        subprocess.call([args.autohotkey, args.target_name + ".ahk", args.images_dir])

    payout = image_converter.get_payout(args.tesseract)


if __name__ == "__main__":
    main()