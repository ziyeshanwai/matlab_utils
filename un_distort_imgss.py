import cv2
import numpy as np


if __name__ == "__main__":
    c1_path = r""
    img_path = r""
    cv_file = cv2.FileStorage(c1_path, cv2.FILE_STORAGE_READ)
    mtx = cv_file.getNode("camera_matrix").mat()
    dist = cv_file.getNode("distortion_coefficients").mat()
    width = cv_file.getNode("image_width")
    if width.isReal():
        width = width.real()
    else:
        if width.isInt():
            width = int(width.real())
        else:
            if width.isSeq():
                default = []
                for i in range(width.size()):
                    v = width.at(i)
                    if v.isInt():
                        default.append(int(v.real()))
                    elif v.isReal():
                        default.append(v.real())
                    else:
                        print('Unexpected value format')
            else:
                if width.isString():
                    width = width.string()

    height = int(cv_file.getNode("image_height").real())
    print(mtx)
    print(dist)
    cv_file.release()
    img = cv2.imread(img_path)
    # un_distort = cv2.fisheye.undistortImage(img, mtx, dist)
    un_distort = cv2.undistort(img, mtx, dist, None, mtx)
    img_cat = np.hstack((img, un_distort))
    cv2.namedWindow("diff", cv2.WINDOW_NORMAL)
    cv2.imshow("diff", img_cat)
    cv2.waitKey(0)