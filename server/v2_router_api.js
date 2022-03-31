const express = require('express');
const { Register, Login } = require('./controller/v2_auth');
const V2DashboaadBeverage = require('./controller/v2_dashboard_beverage');
const V2DashboardFood = require('./controller/v2_dashboard_food');
const V2DashboardOther = require('./controller/v2_dashboard_other');
const V2ListUser = require('./controller/v2_list_user');
const V2MasterDep = require('./controller/v2_master_dep');
const V2MasterOutlet = require('./controller/v2_master_outlet');
const V2Register = require('./controller/v2_register');
const SalesPerformanceWeek = require('./controller/v2_salesperformance_week');
const SalesPerformanceMonth = require('./controller/v2_sales_performance_month');
const V2Top10Beverage = require('./controller/v2_top_10beverage');
const V2Top10Food = require('./controller/v2_top_10food');
const V2Top10Other = require('./controller/v2_top_10other');
const V2TotalRevenue = require('./controller/v2_total_revenue');
const { Food } = require('./tgho_controller/dashboard');
const V2Api = express.Router();

V2Api.get('/food', V2DashboardFood)
V2Api.get('/beverage', V2DashboaadBeverage)
V2Api.get('/other', V2DashboardOther)
V2Api.get('/masterOut', V2MasterOutlet);
V2Api.get('/masterDep', V2MasterDep);
V2Api.get('/register', Register);
V2Api.post('/login', Login)
V2Api.get('/totalRevenue', V2TotalRevenue)
V2Api.get('/salesPerformanceWeek', SalesPerformanceWeek)
V2Api.get('/salesPerformanceMonth', SalesPerformanceMonth)
V2Api.post('/register', V2Register);
V2Api.get('/listUser', V2ListUser);
V2Api.get('/top10Food', V2Top10Food);
V2Api.get('/top10Beverage', V2Top10Beverage);
V2Api.get('/top10Other', V2Top10Other);

// V2Api.get('/new/food', Food)

module.exports = V2Api;