class Classroom
  attr_reader :at_cun, :at_xiang
  attr_accessor :xiaoqu, :limit_start_num

  def initialize(xiaoqu="cun")

    at_cun =<<-EOF
      信1002 信1004 信1006 信1008 信1010 信2002 信2004 信2006 信2008 信2010 信3002
      信3004 信3006 信3008 信3010 信4002 信4004 信4006 信4008 信4010 信5002 信5004
      信5006 信5008 信5010 信6002 信6004 信6006
      3-308 3-310 3-311 3-312 3-313 3-314 3-315 3-318 3-324 3-325 3-327
      3-329 3-330 3-335 3-337 3-338
      3-341 3-401 3-402 3-404 3-406 3-407 3-408 3-410 3-411 3-412 3-413
      3-414 3-415 3-416 3-418 3-422 3-423 3-425 3-427 3-428 3-429 3-430
      3-434 3-435 3-436 3-437 3-438 3-440 4-333
      中211 中322 中328
    EOF
    @at_cun = at_cun.split
    at_xiang =<<-EOF
      良乡1-101 良乡1-102 良乡1-103 良乡1-104 良乡1-105 良乡1-106 良乡1-107 良乡1-108 良乡1-109
      良乡1-201 良乡1-202 良乡1-203 良乡1-204 良乡1-205 良乡1-206 良乡1-207 良乡1-208 良乡1-209 良乡1-210
      良乡1-301 良乡1-302 良乡1-303 良乡1-304 良乡1-305 良乡1-306 良乡1-307 良乡1-308 良乡1-309 良乡1-310
      良乡1-401 良乡1-402 良乡1-403 良乡1-404 良乡1-405 良乡1-406 良乡1-407 良乡1-408 良乡1-409
      良乡1-505 良乡1-506
      良乡2-A105 良乡2-A106 良乡2-A201 良乡2-A202 良乡2-A203 良乡2-A204 良乡2-A205 良乡2-A206
      良乡2-A301 良乡2-A302 良乡2-A303 良乡2-A304 良乡2-A305 良乡2-A306
      良乡2-A401 良乡2-A402 良乡2-A403 良乡2-A404 良乡2-A405 良乡2-A406
      良乡2-A501 良乡2-A502 良乡2-A503 良乡2-A504
      良乡2-B101 良乡2-B102 良乡2-B103 良乡2-B104 良乡2-B105
      良乡2-B201 良乡2-B202 良乡2-B203 良乡2-B204 良乡2-B205 良乡2-B206
      良乡2-B301 良乡2-B302 良乡2-B303 良乡2-B304 良乡2-B305 良乡2-B306
      良乡2-B405 良乡2-B406 良乡2-B501 良乡2-B502 良乡2-B503 良乡2-B504 良乡2-B505
    EOF
    @at_xiang = at_xiang.split

    @xiaoqu = @at_xiang
    @xiaoqu = @at_cun if xiaoqu == 'cun'

  end

  def get_limit_num
    t = Time.now
    h, m = t.hour, t.min
    if h <= 9 && m < 35
      1
    elsif h <=12
      3
    elsif h <= 14 && m < 55
      6
    elsif h <= 17 && m < 35
      8
    else
      p h,m
      11
    end
  end

  def get_classroom
    limit_num = get_limit_num
    list = WeekSchedule.where(:start_at_num.gte => limit_num)
    first, second, third, fourth, fifth = [],[],[],[],[]
    list.each do |e|
      if !e.nil? && @xiaoqu.include?(e.classroom)
        if e.start_at_num == 1
          p "hello"
          first << e.classroom
        elsif e.start_at_num == 3
          second << e.classroom
        elsif e.start_at_num == 6
          third << e.classroom
        elsif e.start_at_num == 8
          fourth << e.classroom
        elsif e.start_at_num == 11
          fifth << e.classroom
        end
      else
        p "pass!"
      end
    end

    look_unused_classroom(first, second, third, fourth, fifth)
  end

  def look_unused_classroom(a, b, c, d, e)
    collection = []
    a_ = @xiaoqu - a
    b_ = @xiaoqu - b
    c_ = @xiaoqu - c
    d_ = @xiaoqu - d
    e_ = @xiaoqu - e

    all_classroom = a_ | b_ | c_ | d_ | e_
    all_classroom.each do |e|
      hash = {}
      hash['weight'] = 0
      hash['classroom'] = e
      collection << hash
    end

    collection = add_weight(collection, a_ & b_, 2)
    collection = add_weight(collection, b_ & c_, 1)
    collection = add_weight(collection, c_ & d_, 2)
    collection = add_weight(collection, d_ & e_, 3)

    p collection.sort_by { |e| -1 * e['weight'] }
  end

  def add_weight(collection, arr, weight)
    arr.each do |e|
      collection.each_with_index do |hash, k|
        if hash['classroom'] == e
          collection[k]['weight'] += weight
          break
        end
      end
    end
    collection
  end
end