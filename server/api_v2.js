const express = require('express');
const { Dashboard } = require('./tgho_controller/dashboard');
const { ByDeptReport } = require('./tgho_controller/dept_report');
const { ProductReportYear } = require('./tgho_controller/product_report_year');

const { YearReport } = require('./tgho_controller/year_report');
const ApiV2 = express.Router();


// with query 
ApiV2.get('/dashboard', Dashboard)
ApiV2.get('/yearReport', YearReport)
ApiV2.get('/deptReport', ByDeptReport)
ApiV2.get('/productReportYear', ProductReportYear)

module.exports = {ApiV2};