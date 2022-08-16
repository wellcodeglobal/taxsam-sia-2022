import { Controller } from 'stimulus';

export default class extends Controller {
  connect(){
    this.donutChart(this.element);
  }

  donutChart(myElement){
    let dataSeries = JSON.parse(myElement.dataset.series)
    let dataCategories = JSON.parse(myElement.dataset.categories)

    var options = {
      series: dataSeries,
      chart: {
        width: 380,
        type: 'pie',
      },
      labels: dataCategories,
      legend: {
        show: true,
        showForSingleSeries: false,
        showForNullSeries: true,
        showForZeroSeries: true,
        position: 'bottom'
      },
      responsive: [{
        breakpoint: 480,
        options: {
          chart: {
            width: 400
          },
          legend: {
            position: 'left'
          }
        }
      }]
    };

    var chart = new ApexCharts(myElement, options);
    chart.render();
  }
}
