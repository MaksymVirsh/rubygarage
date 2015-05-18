angular.module('app').filter 'bytes', () ->
  (bytes, precision) ->
    return '0 bytes' if bytes == 0
    return '-' if isNaN(parseFloat(bytes)) or !isFinite(bytes)
    precision = 1 if (typeof precision == 'undefined')

    units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
    number = Math.floor(Math.log(bytes) / Math.log(1024))
    val = (bytes / Math.pow(1024, Math.floor(number))).toFixed(precision)

    val = if val.match(/\.0*$/) then val.substr(0, val.indexOf('.')) else val
    val +  ' ' + units[number]
