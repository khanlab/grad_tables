function convertMrtrixTableToSiemens (dirgen_txt, num_b0s, out_file )

% obtain optimal sampling from mrtrix3 dirgen tool

% gen_scheme 1 1000 30 2000 60 %this generates 5 b0, 30 b1000, 60 b2000


% assumes that an implicit first grad direction is always added b=0 --
% siemens does this


optimal=importdata(dirgen_txt);

%rearrange to look like inria table
optimal_data=optimal(:,[4,1,2,3]);

ndir=size(optimal_data,1);

%number of b0 (excluding implicit 1)
nb0_between=num_b0s;

nb0_init=0;
nb0_implicit=1;

nb0=nb0_init+nb0_between+nb0_implicit;


%intersperse the b0's..
spacing=ceil(ndir/nb0);


% siemens scanner puts a b0 automatically, so don't need this..
 %put first zero

 if(nb0_init>0);
 sampling_withb0=[zeros(nb0_init,4); optimal_data];
 else
 sampling_withb0=optimal_data;
 end
 


for i=1:nb0_between
    
   insertion=i+spacing*i;
   sampling_withb0=[sampling_withb0(1:insertion,:); zeros(1,4); sampling_withb0((insertion+1):end,:);];
   
end

shell=sampling_withb0(:,1);

nshells=max(shell);
normshell=shell./nshells;

bval=sqrt(normshell);


bvec=repmat(bval,1,3).*sampling_withb0(:,2:4);

%  figure; scatter3(bvec(:,1),bvec(:,2),bvec(:,3),100,bval); axis equal;

% write bvec to dvs file

%out_file=sprintf('optimal_sampling_%d_shells_%d_dir_%d_b0.dvs',nshells,ndir,nb0);
fid=fopen(out_file,'w');
fprintf(fid,'# Vector set from optimal sampling of %d directions, and %d b0 (including implicit b0 added by console)\n',ndir,nb0);
fprintf(fid,'[directions=%d]\n',size(bvec,1));
fprintf(fid,'CoordinateSystem = xyz\n');
fprintf(fid,'Normalisation = none\n');

for i=1:size(bvec,1)

fprintf(fid,'Vector[%d] = (\t %1.6f, \t %1.6f, \t %1.6f )\n',i-1,bvec(i,:));
norm(bvec(i,:));

end

fclose(fid);

end

