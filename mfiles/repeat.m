% (C) RAHUL KUMAR BHADANI

smaster = "";
pose = 0;
for i = 1:1
      s1= sprintf("<actor name='actor_%0.3d'>",i);
      newline = "\n";
      s2 = sprintf("<pose>%d 0 0 0 0 0</pose>",pose);
      s3= "<include>";
      s4 = sprintf("<name>car_%0.3d</name>",i);
      s5 = "<pose>0 0 0 0 0 0</pose>";
      s6 = "<uri>model://hatchback_red</uri>";
      s7 = "</include>";
      s8="<script><loop>true</loop><delay_start>0.000000</delay_start><auto_start>true</auto_start>";
      s9="<trajectory id='0' type='animation'>";
      s10=sprintf("<waypoint><time>0</time><pose>%d 0 0 0 0 0</pose></waypoint>", pose);
      s11 = sprintf("<waypoint><time>43</time><pose>%d 0 0 0 0</pose></waypoint>",pose+900);
      s12 ="</trajectory>";
      s13= "</script>";
      s14 = "</actor>";
      s = strcat(s1,newline,s2, newline, s3, newline,s4, newline, s5, newline, s6, newline, s7, newline,newline,  s8, newline,...
          s9, newline, s10, newline, s11, newline, s12, newline, s13, newline, s14, newline);
      smaster = strcat(smaster, s);
      pose = pose + 20;
end

fid = fopen('s.txt','wt');
fprintf(fid, smaster);
fclose(fid);