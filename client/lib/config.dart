class Config{ static const isDevAndroid = false; static const isDevWeb = true; static const weblUrl = 'http://127.0.0.1:3000/apiv2'; static const androidUrl = 'http://10.0.2.2:3000/apiv2'; static const serverUrl = 'http://116.193.191.104:3000/apiv2'; static const getUrl = isDevAndroid? androidUrl : isDevWeb? weblUrl : serverUrl; }
