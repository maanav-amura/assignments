// Units place different variations
var unitsNum = [
  '',
  ' One',
  ' Two',
  ' Three',
  ' Four',
  ' Five',
  ' Six',
  ' Seven',
  ' Eight',
  ' Nine',
  ' Ten',
  ' Eleven',
  ' Twelve',
  ' Thirteen',
  ' Fourteen',
  ' Fifteen',
  ' Sixteen',
  ' Seventeen',
  ' Eighteen',
  ' Nineteen'
];

// Tens place different variations
var tensNum = [
  '',
  ' Ten',
  ' Twenty',
  ' Thirty',
  ' Forty',
  ' Fifty',
  ' Sixty',
  ' Seventy',
  ' Eighty',
  ' Ninety'
];

// Different denominations in Indian currency
var bigNum = [
  '',
  ' Thousands',
  ' Lakhs',
  ' Crores'
];

// Convent the number in the form of 'Hundreds, Tens Units'
function convertLessThousand(number) {
  var output = '';
  var tens = number % 100;
  if(tens >= 20) {
    output += tensNum[Math.floor(tens / 10)];
    tens = tens%10;
  }
  output += unitsNum[tens];
  var hundreds = Math.floor((number % 1000) / 100);
  if (hundreds !== 0) {
    if ((number%1000)%100 !== 0) {
      output = unitsNum[hundreds] + ' Hundreds,' + output;
    } else {
      output = unitsNum[hundreds] + ' Hundreds';
    }
  }
  return output;
}

// convert the number in the form of 'Crores, Lakhs, Thousands'
function convert(number) {
  var comma = '';           // Add comma if there was no zero's trailing
  if (number%1000 !== 0) {
    comma = ',';
  }
  number = Math.floor(number / 1000); // Omit the number smaller than Thousands
  var bigCount = 0;
  if(number === 0) {  // return if the number has no Thousands and more
    return '';
  }
  var output = '';
  do {
    var temp = number % 100;
    number = Math.floor(number/100)
    bigCount += 1;          // Increasing denominations
    temp = convertLessThousand(temp);   // Convert the number with tens and units place
    if (temp !== '') {
      output = temp + bigNum[bigCount] + comma + output;
      comma = ',';          // Add comma if the number trailing is non-zero
    } else {
      comma = '';           // Remove comma if the number trailing is zero
    }
  }while(number !== 0);     // For denominations increasing as Thousands, Lakhs, Crores
  return output;
}

// Adding humanize function to class String
// Method can be invoked as String.humanize()
String.prototype.humanize = function () {
  var number = parseInt(this);
  if (number === 0) {
    return ' zero';
  }
  var output = convertLessThousand(number);
  return convert(number) + output;
}

// Test cases
console.log('0'.humanize());
console.log('8'.humanize());
console.log('16'.humanize());
console.log('19'.humanize());
console.log('27'.humanize());
console.log('85'.humanize());
console.log('91'.humanize());
console.log('90'.humanize());
console.log('185'.humanize());
console.log('501'.humanize());
console.log('900'.humanize());
console.log('720'.humanize());
console.log('1209'.humanize());
console.log('23721'.humanize());
console.log('99831'.humanize());
console.log('90000'.humanize());
console.log('10700'.humanize());
console.log('111209'.humanize());
console.log('123721'.humanize());
console.log('2199831'.humanize());
console.log('2090000'.humanize());
console.log('7110700'.humanize());
console.log('500000'.humanize());
console.log('1123721'.humanize());
console.log('102199831'.humanize());
console.log('222090000'.humanize());
console.log('100000000'.humanize());
console.log('11500000'.humanize());
