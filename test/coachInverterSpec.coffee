expect = require("chai").expect
cheerio = require("cheerio")
inverter = require("../coachInverter.js")

describe "coachInverter", ->
  it "should invert l->r", ->
    $ = cheerio.load("<div class=\"empty y05 desk x2 l\"><span>Stolek</span></div>")
    inverter $
    expect($.html()).to.be.equal "<div class=\"empty y05 desk x2 r\"><span>Stolek</span></div>"

  it "should invert r->l", ->
    $ = cheerio.load("<div class=\"empty y05 desk x2 r\"><span>Stolek</span></div>")
    inverter $
    expect($.html()).to.be.equal "<div class=\"empty y05 desk x2 l\"><span>Stolek</span></div>"

  it "should invert left->right", ->
    $ = cheerio.load('<div class="empty x2 y3 cube toilet left"><span><em class="icon60"></em><i>Toaleta</i></span></div>')
    inverter $
    expect($.html()).to.be.equal '<div class="empty x2 y3 cube toilet right"><span><em class="icon60"></em><i>Toaleta</i></span></div>'

  it "should invert right->left", ->
    $ = cheerio.load('<div class="empty x2 y3 cube toilet right"><span><em class="icon60"></em><i>Toaleta</i></span></div>')
    inverter $
    expect($.html()).to.be.equal '<div class="empty x2 y3 cube toilet left"><span><em class="icon60"></em><i>Toaleta</i></span></div>'

  it "should invert top->bottom", ->
    $ = cheerio.load("<div class=\"empty x5 y1 entrance top\"><span></span></div>")
    inverter $
    expect($.html()).to.be.equal "<div class=\"empty x5 y1 entrance bottom\"><span></span></div>"

  it "should invert bottom->top", ->
    $ = cheerio.load("<div class=\"empty x5 y1 entrance bottom\"><span></span></div>")
    inverter $
    expect($.html()).to.be.equal "<div class=\"empty x5 y1 entrance top\"><span></span></div>"

  it 'should invert back seats to front', ->
    $ = cheerio.load('<a class="seat back" seat="189"></a>')
    inverter $
    expect($.html()).to.be.equal '<a class="seat" seat="189"></a>'

  it 'should invert front seats to back', ->
    $ = cheerio.load('<a class="seat" seat="189"></a>')
    inverter $
    expect($.html()).to.be.equal '<a class="seat back" seat="189"></a>'


  it "should place clearfix at the end", ->
    $ = cheerio.load(
      """
      <div class="coach">
        <div class="series">
          <a class="seat back" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
        <div class="clearfix"></div>
      </div>
      """.replace(/>\s+</g, '><'))
    inverter $
    expected =
      """
      <div class="coach">
        <div class="series">
          <a class="seat" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
        <div class="clearfix"></div>
      </div>
      """.replace(/>\s+</g, '><')
    expect($.html()).to.be.equal expected

  it "should place clearfix before bottom entrance", ->
    $ = cheerio.load(
      """
      <div class="coach">
        <div class="empty x5 y1 entrance top"><span></span></div>
        <div class="series">
          <a class="seat back" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
        <div class="clearfix"></div>
        <div class="empty x5 y1 entrance bottom"><span></span></div>
      </div>
      """.replace(/>\s+</g, '><'))
    inverter $
    expected =
      """
      <div class="coach">
        <div class="empty x5 y1 entrance top"><span></span></div>
        <div class="series">
          <a class="seat" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
        <div class="clearfix"></div>
        <div class="empty x5 y1 entrance bottom"><span></span></div>
      </div>
      """.replace(/>\s+</g, '><')
    expect($.html()).to.be.equal expected


  it "should reverse series", ->
    $ = cheerio.load(
      """
      <div class="coach">
        <div class="series">
          <a class="seat back" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
        <div class="series">
          <div class="empty y05 title ext"><span>Economy</span></div>
        </div>
        <div class="series">
          <a class="seat" seat="183"><span class="wrap"><span class="base"><i><b>183</b></i></span></span></a>
        </div>
      </div>
      """.replace(/>\s+</g, '><'))
    inverter $
    expected =
      """
      <div class="coach">
        <div class="series">
          <a class="seat back" seat="183"><span class="wrap"><span class="base"><i><b>183</b></i></span></span></a>
        </div>
        <div class="series">
          <div class="empty y05 title ext"><span>Economy</span></div>
        </div>
        <div class="series">
          <a class="seat" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
      </div>
      """.replace(/>\s+</g, '><')
    expect($.html()).to.be.equal expected

  it "should reverse items in a series", ->
    $ = cheerio.load(
      """
      <div class="coach">
        <div class="series">
          <a class="seat back" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
          <a class="seat back" seat="188"><span class="wrap"><span class="base"><i><b>188</b></i></span></span></a>
          <div class="empty"></div>
          <a class="seat back" seat="187"><span class="wrap"><span class="base"><i><b>187</b></i></span></span></a>
          <a class="seat back" seat="186"><span class="wrap"><span class="base"><i><b>186</b></i></span></span></a>
        </div>
      </div>
      """.replace(/>\s+</g, '><'))
    inverter $
    expected =
      """
      <div class="coach">
        <div class="series">
          <a class="seat" seat="186"><span class="wrap"><span class="base"><i><b>186</b></i></span></span></a>
          <a class="seat" seat="187"><span class="wrap"><span class="base"><i><b>187</b></i></span></span></a>
          <div class="empty"></div>
          <a class="seat" seat="188"><span class="wrap"><span class="base"><i><b>188</b></i></span></span></a>
          <a class="seat" seat="189"><span class="wrap"><span class="base"><i><b>189</b></i></span></span></a>
        </div>
      </div>
      """.replace(/>\s+</g, '><')
    expect($.html()).to.be.equal expected

  it "should reverse items in a wrapper", ->
    $ = cheerio.load(
      """
      <div class="coach">
        <div class="series">
          <div class="empty x2 y3 cube toilet"><span><em class="icon60"></em><i>Toaleta</i></span></div>
          <div class="wrapper x3 y3">
            <div class="empty x3 y2"></div>
            <div class="empty x2"></div>
            <a class="" seat="57"><span class="wrap"><span class="base"><i><b>57</b></i></span></span></a>
          </div>
        </div>
      </div>
      """.replace(/>\s+</g, '><'))
    inverter $
    expected =
      """
      <div class="coach">
        <div class="series">
          <div class="wrapper x3 y3">
            <a class="" seat="57"><span class="wrap"><span class="base"><i><b>57</b></i></span></span></a>
            <div class="empty x2"></div>
            <div class="empty x3 y2"></div>
          </div>
          <div class="empty x2 y3 cube toilet"><span><em class="icon60"></em><i>Toaleta</i></span></div>
        </div>
      </div>
      """.replace(/>\s+</g, '><')
    expect($.html()).to.be.equal expected
