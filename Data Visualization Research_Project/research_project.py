# -*- coding: utf-8 -*-
"""
Created on Sat Oct 24 12:52:16 2020

@author: Luis Sanchez

This file is a final research project in which I implement the practice of Wed scraping
"""

import requests
import bs4
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import re


def process_num(num):
    return float(re.sub(r'[^\w\s.]','',num))

url ="https://www.gpucheck.com/gpu-benchmark-graphics-card-comparison-chart"
req = requests.get(url)  
soup = bs4.BeautifulSoup(req.text, "html.parser")
soup = soup.find_all("table")

years = []
prices = []
names = []
index_ = []
avg1080 = []
avg1440 = []
avg4k = []
brands = []
nv = "Nvidia"
amd = "Amd"
#storing the data for the dataframe
for table in soup:
    rows = table.find_all('tr')
    
    for row in rows:
        cells = row.find_all('td')
        
        
        if len(cells) > 1:
            year = cells[0]
            years.append(int(year.text)) #year data
            
            name = cells[1]
            names.append(name.text.strip()) # name of the GPU
            
            price = cells[2]
            prices.append(process_num(price.text.strip())) #Price of the gpu
            
            indx = cells[3]
            index_.append(process_num(indx.text.strip())) # index of performance gpu
            
            avg_1080 = cells[4]
            avg1080.append(process_num(avg_1080.text.strip())) #average performance for 1080 FPS
            
            avg_1440 = cells[5]
            avg1440.append(process_num(avg_1440.text.strip())) # average performance for 1440 FPS
            
            avg_4k = cells[6]
            avg4k.append(process_num(avg_4k.text.strip())) # average performance for 4K
#end

 #create dataframe           
df1 = pd.DataFrame(names,columns=['name'])
df1['year'] = years
df1['price'] = prices
df1['Index of Performance'] = index_
df1['avg 1080p FPS'] = avg1080
df1['avg 1440p FPS'] = avg1440
df1['avg 4K FPS'] = avg4k

#end

#save to a csv file
df1.to_csv('gpu_research.csv', index=False)
#end

#scatter plot price pay for performance
fig, ax = plt.subplots()
cm =plt.cm.get_cmap('jet')
df1.plot.scatter(x='Index of Performance', y='price', s=df1['price']*0.05,
                c=df1.year, ax=ax, cmap=cm)
ax.set(title='Price per Performance', xlabel='Index of Performance', ylabel='Price')
#end

#histogram
fig, ax = plt.subplots()
df1['year'].plot.hist(ax=ax)
ax.set(title='Releases per year', xlabel='Year', ylabel='Number of GPUs')
plt.show()
#end
