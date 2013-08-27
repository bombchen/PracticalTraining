$.extend({
    cookie:function (name, value, options) {
        var cookies, cookie, i, l, _ = {};
        if (!name) {
            if (document.cookie && document.cookie != '') {
                cookies = document.cookie.split(';');
                for (i = 0, l = cookies.length; i < l; i++) {
                    cookie = $.trim(cookies[i]).split('=');
                    _[cookie[0]] = decodeURIComponent(cookie[1]);
                }
            }
            return _;
        }
        if (typeof value != 'undefined') {
            options = options || {};
            var def = {};
            options = $.extend(def, options);
            if (value === null) {
                value = '';
                options.expires = -1;
            }
            var expires = '';
            if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
                var date;
                if (typeof options.expires == 'number') {
                    date = new Date();
                    date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
                } else {
                    date = options.expires;
                }
                expires = '; expires=' + date.toUTCString();
            }
            var path = options.path ? '; path=' + (options.path) : '';
            var domain = options.domain ? '; domain=' + (options.domain) : '';
            var secure = options.secure ? '; secure' : '';
            document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
        } else {
            var cookieValue = null;
            if (document.cookie && document.cookie != '') {
                cookies = document.cookie.split(';');
                for (i = 0, l = cookies.length; i < l; i++) {
                    cookie = $.trim(cookies[i]);
                    if (cookie.substring(0, name.length + 1) == (name + '=')) {
                        cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                        break;
                    }
                }
            }
            return cookieValue;
        }
    }
});
$(document).ready(function(){
    var token = $('meta[name="csrf-token"]').attr('content');
    if(token){
        $.CSRF = token;
        $.ajaxSetup({
            headers:{
                'X-CSRF-Token': $.CSRF
            }
        });
    }
    $(document).ajaxComplete(function(event,xhr){
        var html=$('<div>'+xhr.responseText+'</div>');
        var token = $('meta[name="csrf-token"]',html).attr('content');
        if(token){
            $.CSRF = token;
            $.ajaxSetup({
                headers:{
                    'X-CSRF-Token': $.CSRF
                }
            });
        }
    });
    var mask=$('.mask');
    if(!mask[0]){
        mask=$('<div class="mask"></div>').appendTo('body');
    }
    $(document).delegate('.open-add','click',function(){
        var self=$(this),
            href=self.attr('href'),
            dialog=$('<div class="dialog"></div>').appendTo('body'),
            close=$('<a href="#" class="dialog-close"></a>');
        mask.removeClass('loaded').show();
        close.bind('click',function(){
            mask.hide();
            dialog.remove();
            return false;
        });
        dialog.load(href+' #content',function(){
            mask.addClass('loaded');
            if(!$('form',dialog)[0]){
                $('#content',dialog).css({width:300});
                $('.form-actions',dialog).remove();
            }
            var w=dialog[0].scrollWidth,
                h=dialog[0].scrollHeight;
            dialog.css({
                marginTop:-(h/2),
                marginLeft:-(w/2)
            });
            close.appendTo(dialog);
            if($('#new_scheduled_course',dialog)[0]){
                $(function () {
                    $('form',dialog).wrapInner('<div class="dialog-form-385"></div>');
                    $('.form-actions',dialog).insertAfter($('.dialog-form-385',dialog));
                    $('<div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 八月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td><td class="day ">2</td><td class="day ">3</td></tr><tr><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td><td class="day ">9</td><td class="day ">10</td></tr><tr><td class="day ">11</td><td class="day ">12</td><td class="day ">13</td><td class="day ">14</td><td class="day ">15</td><td class="day ">16</td><td class="day ">17</td></tr><tr><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day  active">21</td><td class="day ">22</td><td class="day ">23</td><td class="day ">24</td></tr><tr><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td><td class="day ">30</td><td class="day ">31</td></tr><tr><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td><td class="day  new">7</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month">六月</span><span class="month">七月</span><span class="month active">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 八月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td><td class="day ">2</td><td class="day ">3</td></tr><tr><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td><td class="day ">9</td><td class="day ">10</td></tr><tr><td class="day ">11</td><td class="day ">12</td><td class="day ">13</td><td class="day ">14</td><td class="day ">15</td><td class="day ">16</td><td class="day ">17</td></tr><tr><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day  active">21</td><td class="day ">22</td><td class="day ">23</td><td class="day ">24</td></tr><tr><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td><td class="day ">30</td><td class="day ">31</td></tr><tr><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td><td class="day  new">7</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month">六月</span><span class="month">七月</span><span class="month active">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 八月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td><td class="day ">2</td><td class="day ">3</td></tr><tr><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td><td class="day ">9</td><td class="day ">10</td></tr><tr><td class="day ">11</td><td class="day ">12</td><td class="day ">13</td><td class="day ">14</td><td class="day ">15</td><td class="day ">16</td><td class="day ">17</td></tr><tr><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day  active">21</td><td class="day ">22</td><td class="day ">23</td><td class="day ">24</td></tr><tr><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td><td class="day ">30</td><td class="day ">31</td></tr><tr><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td><td class="day  new">7</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month">六月</span><span class="month">七月</span><span class="month active">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 八月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td><td class="day ">2</td><td class="day ">3</td></tr><tr><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td><td class="day ">9</td><td class="day ">10</td></tr><tr><td class="day ">11</td><td class="day ">12</td><td class="day ">13</td><td class="day ">14</td><td class="day ">15</td><td class="day ">16</td><td class="day ">17</td></tr><tr><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day  active">21</td><td class="day ">22</td><td class="day ">23</td><td class="day ">24</td></tr><tr><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td><td class="day ">30</td><td class="day ">31</td></tr><tr><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td><td class="day  new">7</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month">六月</span><span class="month">七月</span><span class="month active">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 六月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">26</td><td class="day  old">27</td><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td></tr><tr><td class="day ">2</td><td class="day ">3</td><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td></tr><tr><td class="day ">9</td><td class="day ">10</td><td class="day ">11</td><td class="day ">12</td><td class="day  active">13</td><td class="day ">14</td><td class="day ">15</td></tr><tr><td class="day ">16</td><td class="day ">17</td><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day ">21</td><td class="day ">22</td></tr><tr><td class="day ">23</td><td class="day ">24</td><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td></tr><tr><td class="day ">30</td><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month active">六月</span><span class="month">七月</span><span class="month">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 六月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">26</td><td class="day  old">27</td><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td></tr><tr><td class="day ">2</td><td class="day ">3</td><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td></tr><tr><td class="day ">9</td><td class="day ">10</td><td class="day ">11</td><td class="day ">12</td><td class="day  active">13</td><td class="day ">14</td><td class="day ">15</td></tr><tr><td class="day ">16</td><td class="day ">17</td><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day ">21</td><td class="day ">22</td></tr><tr><td class="day ">23</td><td class="day ">24</td><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td></tr><tr><td class="day ">30</td><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month active">六月</span><span class="month">七月</span><span class="month">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 六月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">26</td><td class="day  old">27</td><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td></tr><tr><td class="day ">2</td><td class="day ">3</td><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td></tr><tr><td class="day ">9</td><td class="day ">10</td><td class="day ">11</td><td class="day ">12</td><td class="day  active">13</td><td class="day ">14</td><td class="day ">15</td></tr><tr><td class="day ">16</td><td class="day ">17</td><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day ">21</td><td class="day ">22</td></tr><tr><td class="day ">23</td><td class="day ">24</td><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td></tr><tr><td class="day ">30</td><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month active">六月</span><span class="month">七月</span><span class="month">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div><div class="datepicker dropdown-menu"><div class="datepicker-days" style="display: block;"><table class=" table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013年 六月</th><th class="next">›</th></tr><tr><th class="dow">日</th><th class="dow">一</th><th class="dow">二</th><th class="dow">三</th><th class="dow">四</th><th class="dow">五</th><th class="dow">六</th></tr></thead><tbody><tr><td class="day  old">26</td><td class="day  old">27</td><td class="day  old">28</td><td class="day  old">29</td><td class="day  old">30</td><td class="day  old">31</td><td class="day ">1</td></tr><tr><td class="day ">2</td><td class="day ">3</td><td class="day ">4</td><td class="day ">5</td><td class="day ">6</td><td class="day ">7</td><td class="day ">8</td></tr><tr><td class="day ">9</td><td class="day ">10</td><td class="day ">11</td><td class="day ">12</td><td class="day  active">13</td><td class="day ">14</td><td class="day ">15</td></tr><tr><td class="day ">16</td><td class="day ">17</td><td class="day ">18</td><td class="day ">19</td><td class="day ">20</td><td class="day ">21</td><td class="day ">22</td></tr><tr><td class="day ">23</td><td class="day ">24</td><td class="day ">25</td><td class="day ">26</td><td class="day ">27</td><td class="day ">28</td><td class="day ">29</td></tr><tr><td class="day ">30</td><td class="day  new">1</td><td class="day  new">2</td><td class="day  new">3</td><td class="day  new">4</td><td class="day  new">5</td><td class="day  new">6</td></tr></tbody></table></div><div class="datepicker-months" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2013</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="month">一月</span><span class="month">二月</span><span class="month">三月</span><span class="month">四月</span><span class="month">五月</span><span class="month active">六月</span><span class="month">七月</span><span class="month">八月</span><span class="month">九月</span><span class="month">十月</span><span class="month">十一月</span><span class="month">十二月</span></td></tr></tbody></table></div><div class="datepicker-years" style="display: none;"><table class="table-condensed"><thead><tr><th class="prev">‹</th><th colspan="5" class="switch">2010-2019</th><th class="next">›</th></tr></thead><tbody><tr><td colspan="7"><span class="year old">2009</span><span class="year">2010</span><span class="year">2011</span><span class="year">2012</span><span class="year active">2013</span><span class="year">2014</span><span class="year">2015</span><span class="year">2016</span><span class="year">2017</span><span class="year">2018</span><span class="year">2019</span><span class="year old">2020</span></td></tr></tbody></table></div></div>').appendTo('body');
                    $('#dp_begin',dialog)
                        .datepicker()
                        .on('changeDate', function (ev) {
                            update_fields();
                            $(this).datepicker('hide');
                        });
                    $('#dp_end',dialog)
                        .datepicker()
                        .on('changeDate', function (ev) {
                            update_fields();
                            $(this).datepicker('hide');
                        });
                    function update_fields() {
                        var url = '/scheduled_courses/get_available_fields'
                            + '?wday=' + $('#ws').val()
                            + '&idx=' + $('#ip').val()
                            + '&bd=' + $('#dp_begin').val()
                            + '&ed=' + $('#dp_end').val()
                            + '&sid=' + $('#sid').val();
                        $.ajax({
                            url: url,
                            success: function (data) {
                                var select = document.getElementById('scheduled_course_field_id');
                                select.options.length = 0;
                                for (var i = 0; i < data.length; i++) {
                                    var d = data[i];
                                    select.options.add(new Option(d[1], d[0]))
                                }
                            }
                        });
                    }
                });
            }
        });
        return false;
    });
    $(document).delegate('.open','click',function(){
        $('#yield_content').attr('class','yield_content_temp').removeAttr('id');
        var self=$(this),
            href=self.attr('href'),
            dialog=$('<div class="dialog"><div id="content"><div id="yield_content"></div></div></div>').appendTo('body'),
            close=$('<a href="#" class="dialog-close"></a>');
        mask.removeClass('loaded').show();
        close.bind('click',function(){
            mask.hide();
            dialog.remove();
            return false;
        });
        $.getScript(href,function(){
            setTimeout(function(){
                mask.addClass('loaded');
                if(!$('form',dialog)[0]){
                    $('#content',dialog).css({width:300});
                    $('.form-actions',dialog).remove();
                }
                var w=dialog[0].scrollWidth,
                    h=dialog[0].scrollHeight;
                dialog.css({
                    marginTop:-(h/2),
                    marginLeft:-(w/2)
                });
                close.appendTo(dialog);
                $('.yield_content_temp').attr('id','yield_content').removeClass('yield_content_temp');
            },10);
        });
        return false;
    });
    $(document).delegate('#left ul a','click',function(){
        $.lastClickButton=$(this);
    });
    $(document).delegate('.dialog form','submit',function(){
        var self=$(this),
            action=self.attr('action');
        $.post(action,self.serialize(),function(html){
            html=$('<div>'+html+'</div>');
            var error=$('#error_explanation',html);
            if(error[0]){
                var message=[];
                $('li',error).each(function(){
                    message.push($(this).text());
                });
                alert(message.join('\n'));
                $(':submit',self).attr('disabled',false).val('提交');
            }else{
                $.lastClickButton.click();
                self.closest('.dialog').remove();
                mask.hide();
            }
        });
        return false;
    });
    $(document).delegate('.form-actions a','click',function(){
        $(this).closest('.dialog').remove();
        mask.hide();
        return false;
    });
    $('.upload').livequery(function(){
        var id='UPLOAD_'+new Date().getTime(),
            self=$(this).attr('id',id),
            action=self.attr('href'),
            settings = {
                flash_url : "/assets/swfupload.swf",
                upload_url: action,
                file_post_name:'file',
                post_params: {
                    'authenticity_token': $.CSRF,
                    'X-CSRF-Token':$.CSRF
                },
                file_size_limit : "2 MB",
                file_types : "*.xls;*.xlsx",
                file_types_description : "选择EXCEL文件",
                file_upload_limit : 100,
                file_queue_limit : 1,
                headers:{
                    'X-CSRF-Token': $.CSRF
                },
                debug: false,

                // Button settings
                button_image_url: "/assets/upload.png",
                button_width: "100",
                button_height: "30",
                button_placeholder_id: id,
                button_text:'',
                button_text_style:'',
                button_text_left_padding:0,
                button_text_top_padding:0,
                button_window_mode:SWFUpload.WINDOW_MODE.TRANSPARENT,
                button_cursor:SWFUpload.CURSOR.HAND,
                // The event handler functions are defined in handlers.js
                file_queue_error_handler : function(file, errorCode, message){
                    switch (errorCode) {
                        case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
                            alert('文件大小超出限制！');
                            break;
                        case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
                            alert('您选择的是一个空文件！');
                            break;
                        case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
                            alert('只能选择EXCEL文件！');
                            break;
                        case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
                            alert('选择的文件个数超出限制！');
                            break;
                    }
                },
                file_dialog_complete_handler : function(numFilesSelected, numFilesQueued){
                    if(numFilesQueued > 0){
                        this.startUpload();
                    }
                },
                upload_start_handler : function(){

                    this.setButtonDisabled(true);
                    this.setButtonCursor(SWFUpload.CURSOR.ARROW);
                },
                upload_error_handler : function(){
                    this.setButtonDisabled(false);
                    this.setButtonCursor(SWFUpload.CURSOR.HAND);
                    alert('操作失败！');
                },
                upload_success_handler : function(){
                    this.setButtonDisabled(false);
                    this.setButtonCursor(SWFUpload.CURSOR.HAND);
                    $.lastClickButton.click();
                    alert('操作成功！');
                }
            };
        new SWFUpload(settings);
    });
});