const {Prisma} = require('@prisma/client')
const express = require('express');


/**
 * @typedef {Object} Query
 * @property {String} tgl
 * @property {String} dep
 * @property {String} out
 * 
 * @description
 * - tgl tanggal
 * - dep departement
 * - out putlet
 */

/**
 * @typedef {{
    pax: true,
    disc: true,
    discrp: true,
    net: true,
    taxrp: true,
    serrp: true,
    gtotal: true,
    total: true,
    cash: true,
    cc: true,
    voucher: true,
    tip: true,
    other: true,
    dc: true,
    gb: true,
    compliment: true,
    card_fee: true,
    rate: true,
    kas_bon: true,
    prive: true,
    charge: true,
    vtax: true,
    vser: true,
    cash_usd: true,
    forex: true,
    diskon: true,
    diskon_sen: true,
    delivery: true,
    avg_br: true,
    free_ts: true,
    Internet: true,
    PREBILLING: true,
    PO: true,
    STT_PRINT: true,
    warna: true,
    prebill: true,
    tipe: true,
    diskon_all: true,
    cekpajak: true,
    stt_pkg_old: true,
    komisi_nom: true,
    skomisi: true,
    akomisi: true,
    ikomisi: true,
    transfer: true,
    discount: true,
    gkomisi: true,
    free_bf: true,
    biaya_dlv: true,
    kd_co: true,
    deposit: true,
    cc2: true,
    card_fee2: true,
    charge2: true,
    CTD: true,
    bill_resto: true,
    bill_room: true,
    fee_lisensi: true,
    stt_pkg: true,
    br_ctr: true,
    printerx: true,
    stt_guest: true,
    totpoint: true,
    komisi_out: true,
    bkomisi_nom: true,
    stt_upload: true
}} ListbillSelect
 */


/**
     * @typedef {{
 *  tgl1: String,
 *  tgl2: String
 *  dep: String,
 *  out: String
 * }} DashboardQuery
 */

/**
 * @typedef {{
    tanggal: {
        gte: Date;
        lte: Date;
    };
    departement: {
        cdept: string;
    };
    outlet: {
        kode_out: string;
    };
}} PropertyQuery
 */

/**
 * @typedef {Object} Parameter
 * @property {express.Request} req
 * @property {express.Response} res 
 * @property {DashboardQuery} query
 */


/**
 * 
 * @typedef {{
    "tgl1": "",
    "tgl2": "",
    "cdep": "",
    "out": ""
}} ParamController
 */

/**
 * @typedef {{
 * id: String,
 * name: String,
 * email: String,
 * password: String,
 * role: String
 * }} ModelUser
 */

