var cheerio = require('cheerio');
var fs = require('fs');
var program = require('commander');

program
  .usage('[options] <inputFile>')
  .option('-o, --output <outputFile>', 'Output file')
  .parse(process.argv);

if (program.args.length == 0) {
  console.log('Missing input file parameter');
  program.help();  // exits automatically
}

var filename = program.args[0];

var input = fs.readFileSync(filename);
var $ = cheerio.load(input);


require('./coachInverter.js')($)


fs.writeFileSync(program.output || (filename+'.out'), $.html());