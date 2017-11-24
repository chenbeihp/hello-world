#!/usr/bin/python
# -*-coding:utf-8-*-
# 调用和风天气API查询当前天气信息
# 2017/07/12

import json
import urllib.request
import os

city = '北京'
# 在和风天气注册后获得的key
key = '5cce4133682a42eda44913e3903a54e9'

city_name = {'北京': 'beijing', '上海': 'shanghai'}
city_hname = city_name.get(city)


# 获取当前天气信息
def get_json(city):
    #url = 'https://free-api.heweather.com/v5/now?city=' + city_hname + '&key=' + key
    url = 'https://free-api.heweather.com/s6/weather/forecast?location=' + city_hname + '&key=' + key# + '&lang=en'
    #    print url
    html = urllib.request.urlopen(url).read()
    return html


#    print html
#    f=open(city_hname+'.txt','w')
#    f.write(html)
#    f.close

# get_json(city)

# 解析json数据
# data=open(city_hname+'.txt').readline()
data = get_json(city)
hjson = json.loads(data)
basic_status = hjson['HeWeather6'][0]['basic']
#nowtq_status = hjson['HeWeather6'][0]['now']
jintian_status = hjson['HeWeather6'][0]['daily_forecast'][0]
mingtian_status = hjson['HeWeather6'][0]['daily_forecast'][1]
houtian_status = hjson['HeWeather6'][0]['daily_forecast'][2]

# print now
# print now_status['cond']['txt'].encode('utf-8')

# 格式化输出城市信息
def basic(databasic):
    country = databasic['cnty']
    city = databasic['location']
    print('国家/城市名称:%s/%s' % (country, city))
    print('信息更新时间:%s' % hjson['HeWeather6'][0]['update']['loc'])


# 输出三天天气预报，输入参数为三天天气字典
def daily_forcast(jintian, mingtian, houtian):
    print('今天白天:')
    print('天气状况:%s' % jintian['cond_txt_d'])
    print('气温：%s ~ %s度' % (jintian['tmp_min'], jintian['tmp_max']))
    print('风向/风力：%s/%s\r\n' % (jintian['wind_dir'], jintian['wind_sc']))

    print('明天白天:')
    print('天气状况:%s' % mingtian['cond_txt_d'])
    print('气温：%s ~ %s度' % (mingtian['tmp_min'], mingtian['tmp_max']))
    print('风向/风力：%s/%s\r\n' % (mingtian['wind_dir'], mingtian['wind_sc']))

    print('后天白天:')
    print('天气状况:%s' % houtian['cond_txt_d'])
    print('气温：%s ~ %s度' % (houtian['tmp_min'], houtian['tmp_max']))
    print('风向/风力：%s/%s\r\n' % (houtian['wind_dir'], houtian['wind_sc']))

basic(basic_status)
daily_forcast(jintian_status, mingtian_status, houtian_status)

