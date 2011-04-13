  
echo ^<?xml version="1.0" encoding="utf-8"?^> > output_win.xml
echo ^<injured_result^> >> output_win.xml


call btred -I extract_rule.pl -l ..\..\data\hasici\hasici_t_pls.fl >> output_win.xml

 
echo ^</injured_result^> >> output_win.xml

