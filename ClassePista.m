classdef ClassePista
   properties
      tempo = 0;
      angulo = 0;
      velocidade_media;
      file_name_csv;
      file_id_csv; 
   end
   methods
       function obj = ClassePista(vel_mps, file_name_csv)
           file_name_csv = file_name_csv + ".txt";
           obj.velocidade_media = vel_mps;
           
           obj.file_name_csv = file_name_csv;
           obj.file_id_csv = fopen(file_name_csv, 'w');
           
       end
       function obj = add_curva(obj,raio_cm, curvatura_deg)
           
           perimetro = pi* (raio_cm/100) * abs(curvatura_deg) /180;
           tempo_medio = perimetro/ obj.velocidade_media;
           obj.tempo = obj.tempo + tempo_medio; 
           
           obj.angulo = obj.angulo + curvatura_deg;
           
           fprintf(obj.file_id_csv,'%f %f\n',obj.tempo, obj.angulo);
           
           
       end
       
       function obj = add_reta(obj,distancia_cm)
           
           tempo_medio = (distancia_cm/100)/ obj.velocidade_media;
           obj.tempo = obj.tempo + tempo_medio; 
           
           fprintf(obj.file_id_csv,'%f %f\n',obj.tempo, obj.angulo);
       end
       
       function delete(obj)
           fclose(obj.file_id_csv);
       end
   end
end