
Highcharts.setOptions({
	global: {
		useUTC: false
	}
});
	
var chart_intenet;
var y = 0;
var data_send=0;
var data_rec=0;
$(document).ready(function() {
	chart_intenet = new Highcharts.Chart({
		chart: {
			renderTo: 'container1',
			defaultSeriesType: 'spline',
			marginRight: 10,
			events: {
				load: function() {
	
					// set up the updating of the chart each second
					var series0 = this.series[0];
					var series1 = this.series[1];
					setInterval(function() {
						var x = (new Date()).getTime();// current time
				
						series0.addPoint([x, data_send], true, true);
						series1.addPoint([x, data_rec], true, true);
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
		exporting: {
			enabled: false
		},
		series: [{
			name: 'send flow',
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
		},
		{
			name: 'rec flow',
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