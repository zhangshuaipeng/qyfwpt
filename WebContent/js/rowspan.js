(function($) { 
	// ����jqueryԴ��Ϳ��Է���$.fn����$.prototype, ֻ��Ϊ�˼������ڰ汾�Ĳ�� 
	// �ű�����jQuery.prototype�����ʽ 
	$.fn.mergeCell = function(options) { 
	return this.each(function() { 
	var cols = options.cols; 
	for ( var i = cols.length - 1; cols[i] != undefined; i--) { 
	// fixbug console���� 
	// console.debug(cols[i]); 
	mergeCell($(this), cols[i]); 
	} 
	dispose($(this)); 
	}); 
	}; 
	// �����javascript��closure��scope����Ƚ����, ���Ǹ�����ڲ�ʹ�õ�private���� 
	// ������Բο�����ǰһƪ�������ܵ��Ǳ��� 
	function mergeCell($table, colIndex) { 
	$table.data('col-content', ''); // ��ŵ�Ԫ������ 
	$table.data('col-rowspan', 1); // ��ż����rowspanֵ Ĭ��Ϊ1 
	$table.data('col-td', $()); // ��ŷ��ֵĵ�һ����ǰһ�бȽϽ����ͬtd(jQuery��װ����), Ĭ��һ��"��"��jquery���� 
	$table.data('trNum', $('tbody tr', $table).length); // Ҫ�������������, �������һ�������⴦��ʱ�����ж�֮�� 
	// ���Ƕ�ÿһ�����ݽ���"ɨ��"���� �ؼ��Ƕ�λcol-td, �����Ӧ��rowspan 
	$('tbody tr', $table).each(function(index) { 
	// td:eq�е�colIndex�������� 
	var $td = $('td:eq(' + colIndex + ')', this); 
	// ȡ����Ԫ��ĵ�ǰ���� 
	var currentContent = $td.html(); 
	// ��һ��ʱ�ߴ˷�֧ 
	if ($table.data('col-content') == '') { 
	$table.data('col-content', currentContent); 
	$table.data('col-td', $td); 
	} else { 
	// ��һ���뵱ǰ��������ͬ 
	if ($table.data('col-content') == currentContent) { 
	// ��һ���뵱ǰ��������ͬ��col-rowspan�ۼ�, ������ֵ 
	var rowspan = $table.data('col-rowspan') + 1; 
	$table.data('col-rowspan', rowspan); 
	// ֵ��ע����� �������$td.remove()�ͻ�������еĴ������Ӱ�� 
	$td.remove(); 
	// ���һ�е�����Ƚ�����һ�� 
	// �������2�� td�е�������һ����, ��ô�����һ�о�Ӧ�ðѴ�ʱ��col-td�ﱣ���td����rowspan 
	if (++index == $table.data('trNum')) 
	$table.data('col-td').attr('rowspan', $table.data('col-rowspan')); 
	} else { // ��һ���뵱ǰ�����ݲ�ͬ 
	// col-rowspanĬ��Ϊ1, ���ͳ�Ƴ���col-rowspanû�б仯, ������ 
	if ($table.data('col-rowspan') != 1) { 
	$table.data('col-td').attr('rowspan', $table.data('col-rowspan')); 
	} 
	// �����һ�γ��ֲ�ͬ���ݵ�td, ��������, ����col-rowspan 
	$table.data('col-td', $td); 
	$table.data('col-content', $td.html()); 
	$table.data('col-rowspan', 1); 
	} 
	} 
	}); 
	} 
	// ͬ���Ǹ�private���� �����ڴ�֮�� 
	function dispose($table) { 
	$table.removeData(); 
	} 
	})(jQuery);