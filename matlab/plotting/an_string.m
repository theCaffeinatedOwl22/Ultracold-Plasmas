an = annotation('textbox');
an.Position = [0.0058    0.8762    0.9919    0.1143];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';
an.FontSize = 12;

dlm = ' - ';
str1 = ['q1' num2str(q1,'%.3g')];
str2 = ['q2' num2str(q2,'%.3g')];
an.String = [str1 dlm str2];
