/**
 * 
 */
function adv_format(value,num) //四舍五入
{
	var a_str = formatnumber(value,num);
	var a_int = parseFloat(a_str);
	if (value.toString().length>a_str.length)
	{
		var b_str = value.toString().substring(a_str.length,a_str.length+1);
		var b_int = parseFloat(b_str);
		if (b_int<5)
		{
			return a_str;
		}
		else
		{
			var bonus_str,bonus_int;
			if (num==0)
			{
				bonus_int = 1;
			}
			else
			{
				bonus_str = "0.";
				for (var i=1; i<num; i++)
					bonus_str+="0";
				bonus_str+="1";
				bonus_int = parseFloat(bonus_str);
			}
			a_str = formatnumber(a_int + bonus_int, num);
		}
	}
	return a_str;
}

function formatnumber(value,num) //直接去尾
{
	var a,b,c,i;
	a = value.toString();
	b = a.indexOf('.');
	c = a.length;
	if (num==0)
	{
		if (b!=-1)
			a = a.substring(0,b);
	}
	else
	{
		if (b==-1)
		{
			a = a + ".";
			for (i=1;i<=num;i++)
				a = a + "0";
		}
		else
		{
			a = a.substring(0,b+num+1);
			for (i=c;i<=b+num;i++)
				a = a + "0";
		}
	}
	return a;
}
