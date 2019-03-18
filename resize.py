import cv2

filename = 'calibration3.jpg'

oriimg = cv2.imread(filename,cv2.IMREAD_COLOR)

newimg = cv2.resize(oriimg, (0,0), fx=0.5, fy=0.5)

#cv2.waitKey(0)
cv2.imwrite("calibrated.jpg", newimg)
