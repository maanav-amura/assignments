var unitsNum = [
  "",
  " One",
  " Two",
  " Three",
  " Four",
  " Five",
  " Six",
  " Seven",
  " Eight",
  " Nine",
  " Ten",
  " Eleven",
  " Twelve",
  " Thirteen",
  " Fourteen",
  " Fifteen",
  " Sixteen",
  " Seventeen",
  " Eighteen",
  " Nineteen"
];

var tensNum = [
  "",
  " Ten",
  " Twenty",
  " Thirty",
  " Forty",
  " Fifty",
  " Sixty",
  " Seventy",
  " Eighty",
  " Ninety"
];

var bigNum = [
  "",
  " Thousands",
  " Lakhs",
  " Crores"
];

function convertLessThousand(number) {
  var output = "";
  var tens = number % 100;
  if(tens >= 20) {
    output += tensNum[Math.floor(tens/10)];
    tens = tens%10;
  }
  output += unitsNum[tens];
  var hundreds = Math.floor((number%1000)/100);
  if (hundreds !== 0) {
    if ((number%1000)%100 !== 0) {
      output = unitsNum[hundreds] + " hundreds," + output;
    } else {
      output = unitsNum[hundreds] + " hundreds";
    }
  }
  return output;
}

function convert(number) {
  var comma = "";
  if (number%1000 !== 0) {
    comma = ","
  }
  number = Math.floor(number / 1000);
  var bigCount = 0;
  if(number === 0) {
    return "";
  }
  var output = "";
  do {
    temp = number % 100;
    number = Math.floor(number/100)
    bigCount += 1;
    temp = convertLessThousand(temp);
    if (temp !== "") {
      output = temp + bigNum[bigCount] + comma + output
      comma = ",";
    } else {
      comma = "";
    }
  }while(number !== 0);
  return output;
}

String.prototype.humanize = function () {
  var number = parseInt(this);
  if (number === 0) {
    return " zero";
  }
  var output = convertLessThousand(number);
  return convert(number) + output;
}

// Test cases
console.log("0".humanize());
console.log("8".humanize());
console.log("16".humanize());
console.log("19".humanize());
console.log("27".humanize());
console.log("85".humanize());
console.log("91".humanize());
console.log("90".humanize());
console.log("185".humanize());
console.log("501".humanize());
console.log("900".humanize());
console.log("720".humanize());
console.log("1209".humanize());
console.log("23721".humanize());
console.log("99831".humanize());
console.log("90000".humanize());
console.log("10700".humanize());
console.log("111209".humanize());
console.log("123721".humanize());
console.log("2199831".humanize());
console.log("2090000".humanize());
console.log("7110700".humanize());
console.log("500000".humanize());
console.log("1123721".humanize());
console.log("102199831".humanize());
console.log("222090000".humanize());
console.log("100000000".humanize());
console.log("11500000".humanize());
