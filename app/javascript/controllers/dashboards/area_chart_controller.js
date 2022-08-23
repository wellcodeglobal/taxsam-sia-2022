import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    this.color = this.element.dataset.color
    this.chartLine(this.element);
  }

  chartLine(myElement){
    let dataSeries = JSON.parse(myElement.dataset.series)
    let dataCategories = JSON.parse(myElement.dataset.categories)

    var options = {
      series: dataSeries,
      chart: {
        id: "GrafikTotalPendapatan",
        type: 'area',
        height: 350,
        stacked: false,
        zoom: {
          enabled: false
        },
        selection: {
          enabled: false
        },
        toolbar: {
          show: true,
          tools: {
            download: true,
            selection: true,
            zoom: true,
            zoomin: true,
            zoomout: true,
            pan: true,
            reset: true,
            customIcons: []
          },
          export: {
            csv: {
              filename: "GrafikTotalPendapatan",
            },
            svg: {
              filename: "GrafikTotalPendapatan",
            },
            png: {
              filename: "GrafikTotalPendapatan",
            }
          },
        }
      },
      dataLabels: {
        enabled: false
      },
      stroke: {
        show: true,
        width: 3
      },
      xaxis: {
        categories: dataCategories
      },
      yaxis: {
        title: {
          text: ''
        },
        labels: {
          style: {
            colors: [],
            fontSize: '10px',
            fontFamily: 'Helvetica, Arial, sans-serif',
            fontWeight: 400,
            cssClass: 'apexcharts-yaxis-label',
          },
          formatter: function (value) {
            if(parseInt(value)){
              return this.formatLabel(value);
            }else{
              return value
            }
          }.bind(this)
        }
      },
      fill: {
        opacity: 1
      },
      tooltip: {
        y: {
          formatter: function (val) {
            return val
          }
        }
      },
      colors:[this.color]
    };

    var chart = new ApexCharts(myElement, options);
    chart.render();
  }

  formatLabel(value){    
    return "Rp." + window.Util.addThousandSeparator(value);
  }
}
