# -*- coding: utf-8 -*-
import numpy as np
import pylab as pl
import matplotlib.pyplot as plt

f = open("../logs/localize-1014-202714.txt")
sourceInLines = f.readlines()

data_all = []

for line in sourceInLines:
        temp1 = line.strip('\n')
        temp2 = temp1.split(',')
        data_all.append(temp2)

print len(data_all)

time_stamp = []
vel_x = []

for i in range(0,len(data_all)):
	time_stamp.append(data_all[i][0])
	vel_x.append(data_all[i][1])

plt.figure('noise')
plt.plot(time_stamp, vel_x, color = 'r', label = 'vel_x')
plt.show()


sampling_rate = 2000
fft_size = 552

t = np.arange(0, 1.0, 1.0/sampling_rate)
x = np.sin(2*np.pi*156.25*t)  + 2*np.sin(2*np.pi*234.375*t)
xs = x[:fft_size]
xf = np.fft.rfft(xs)/fft_size
freqs = np.linspace(0, sampling_rate/2, fft_size/2+1)
xfp = 20*np.log10(np.clip(np.abs(xf), 1e-20, 1e100))
pl.figure(1)
pl.subplot(211)
pl.plot(t[:fft_size], xs)
pl.xlabel(u"时间(秒)")
pl.title(u"156.25Hz和234.375Hz的波形和频谱")
pl.subplot(212)
pl.plot(freqs, xfp)
pl.xlabel(u"频率(Hz)")
pl.subplots_adjust(hspace=0.4)
pl.show()


