const express = require('express');
const { Dashboard } = require('./tgho_controller/dashboard');
const { ByDeptReport } = require('./tgho_controller/dept_report');
const { ProductReportMonth } = require('./tgho_controller/product_report_month');
const { ProductReportToday } = require('./tgho_controller/product_report_today');
const { ProductreportWeek } = require('./tgho_controller/product_report_week');
const { ProductReportYear } = require('./tgho_controller/product_report_year');

const { YearReport } = require('./tgho_controller/year_report');
const {Revenue} = require('./tgho_controller/revenue');
const { TgLogin } = require('./tgho_controller/tg_login');
const ApiV2 = express.Router();

ApiV2.get("/ping", (req, res) => {
    res.send(true);
});

// with query 
ApiV2.get('/dashboard', Dashboard)
ApiV2.get('/yearReport', YearReport)
ApiV2.get('/deptReport', ByDeptReport)

ApiV2.get('/productReportYear', ProductReportYear)
ApiV2.get('/productReportMonth', ProductReportMonth)
ApiV2.get('/productReportWeek', ProductreportWeek)
ApiV2.get('/productReportToday', ProductReportToday)

ApiV2.get('/revenue', Revenue);
ApiV2.post('/login', TgLogin);

ApiV2.get('/listApi', (req, res) => {
    res.send({
        "dashboard": "/api/v2/dashboard",
        "yearReport": "/api/v2/yearReport",
        "deptReport": "/api/v2/deptReport",
        "productReportYear": "/api/v2/productReportYear",
        "productReportMonth": "/api/v2/productReportMonth",
        "productReportWeek": "/api/v2/productReportWeek",
        "productReportToday": "/api/v2/productReportToday",
        "revenue": "/api/v2/revenue"
    })
});

module.exports = {ApiV2};