import cv2 ,os
#from matplotlib import pyplot as plt 
  
#通过cv2中的类获取视频流操作对象cap 
cap = cv2.VideoCapture("http://192.168.31.147:8080/video") 
#调用cv2方法获取cap的视频帧（帧：每秒多少张图片） 
fps = cap.get(cv2.CAP_PROP_FPS) 
print(fps) 
#获取cap视频流的每帧大小 
size = (int(cap.get(cv2.CAP_PROP_FRAME_WIDTH)), 
    int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))) 
print(size) 
  
#定义编码格式mpge-4 
fourcc = cv2.VideoWriter_fourcc('M', 'P', '4', '2') 
#定义视频文件输入对象 
outVideo = cv2.VideoWriter('images/'+'cut_'+'saveDir'+'.avi',fourcc,fps,size) 
  
#获取视频流打开状态 
if cap.isOpened(): 
  rval,frame = cap.read() 
  print('ture') 
else: 
  rval = False
  print('False') 
  
tot=1
c=1
#循环使用cv2的read()方法读取视频帧
pathf = 'm.xml'
face_cascade = cv2.CascadeClassifier('m.xml')
face_cascade.load(pathf)
count = 0
while rval: 
  rval,frame = cap.read()
  gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
  faces = face_cascade.detectMultiScale(gray, 1.2,3,0)
  for (x, y , w, h) in faces:
    frame = cv2.rectangle(frame, (x, y), (x+w, y+h),(255,0,0),2)
    f = cv2.resize(gray[y:y+h, x:x+w], (200,200))
    #cv2.imwrite('/image/%s.jpg' % str(count) , f)
    #cv2.imwrite('image/'+'cut_'+str(count)+'.jpg',frame)
    count +=1 	
  cv2.imshow('test',frame) 
  #每间隔20帧保存一张图像帧 
  # if tot % 20 ==0 : 
  #   cv2.imwrite('cut/'+'cut_'+str(c)+'.jpg',frame) 
  #   c+=1 
  tot+=1
  print('tot=',tot) 
  #使用VideoWriter类中的write(frame)方法，将图像帧写入视频文件 
  outVideo.write(frame) 
  cv2.waitKey(1) 
cap.release() 
outVideo.release() 
#cv2.destroyAllWindows()
