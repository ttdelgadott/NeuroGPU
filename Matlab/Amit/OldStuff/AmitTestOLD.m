fid = fopen ('../Neuron/printCell/Amit/na.mod');
text = fscanf(fid, '%c');
%disp(text);
commentI = strfind(text, 'COMMENT');
endCommentI = strfind(text,'ENDCOMMENT');

endCommentI = endCommentI+ 3;
commentI = commentI - endCommentI;

disp(commentI);
disp(endCommentI);

a = [2,3,4,5];
b = [0,3,22,3];
any(b==a)

%end