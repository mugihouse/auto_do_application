var ctx = document.getElementById("chart");
const weekTask = gon.total;

var chart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['6日前', '5日前', '4日前', '3日前', '2日前', '1日前', '今日'],
    datasets: [
      {
        label: '1週間で終えたタスク',
        data: weekTask,
        borderColor: "#7B9AA5",
        backgroundColor: "#7B9AA5",
      }
    ],
  },
  options: {
    title: {
      display: true,
      text: '7日間の投稿数の比較'
    },
    scale: {
      ticks: {
        min: 0,
        max: 100,
        stepSize: 10
      }
    }
  }
});
