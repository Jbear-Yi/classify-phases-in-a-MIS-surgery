function labelseq_hot=hotencoding(labelseq,classes)
    [num_seq,vec] = size(labelseq);
    for j=1:vec
        labelseq_hot{j}=zeros(numel(classes),num_seq);
        for i=1:num_seq
            pos = labelseq(i,j)==classes;
            labelseq_hot{j}(:,i)=pos;
        end
    end
end