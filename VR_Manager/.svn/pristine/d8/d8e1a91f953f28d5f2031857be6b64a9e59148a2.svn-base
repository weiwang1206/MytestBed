Highcharts.setOptions({
	global: {
		useUTC: false
	}
});
	
var chart;
var y = 0;
var flow6 = 0;
$(document).ready(function() {
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'container6',
			defaultSeriesType: 'spline',
			marginRight: 10,
			events: {
				load: function() {
	
					// set up the updating of the chart each second
					var series = this.series[0];
					setInterval(function() {
						var x = (new Date()).getTime();// current time
						series.addPoint([x, flow6], true, true);
					}, 1000);
				}
			}
		},
		title: {
			text: 'ÍøÂçÁ÷Á¿(bps)'
		},
		xAxis: {
			type: 'datetime',
			tickPixelInterval: 150
		},
		yAxis: {
			max: 100,
			min:0,
			title: {
				text: ''
			},
			plotLines: [{
				value: 0,
				width: 1,
				color: '#808080'
			}]
		},
		tooltip: {
			formatter: function() {
					return '<b>'+ this.series.name +'</b><br/>'+
					Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) +'<br/>'+ 
					Highcharts.numberFormat(this.y, 2);
			}
		},
		legend: {
			enabled: false
		},
		exporting: {
			enabled: false
		},
		series: [{
			name: 'cpu usage',
			data: (function() {
				// generate an array of random data
				var data = [],
					time = (new Date()).getTime(),
					i;
				
				for (i = -9; i <= 0; i++) {
					data.push({
						x: time + i * 1000,
						y: 0
					});
				}
				return data;
			})()
		}]
	});
	
	
});