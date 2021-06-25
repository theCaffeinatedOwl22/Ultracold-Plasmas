an = annotation('textbox');
an.Position = [0.0058    0.8762    0.9919    0.1143];
an.HorizontalAlignment = 'center';
an.VerticalAlignment = 'middle';
an.LineStyle = 'none';
an.FontSize = 12;

dlm = '-';
str1 = ['Phase' num2str(s.phase)];
str2 = ['Fields' num2str(s.mag)];
str3 = ['Te' num2str(s.Te)];
str4 = ['t' num2str(s.t) 'us'];
str5 = ['t' num2str(s.tau) '\tau'];
an.String = ['RE Fit Results' dlm str1 dlm str3 dlm str2 dlm str4 dlm str5];
