function timestamp = getTimeStamp()
% function timestring = getTimeStamp()
dt       =datetime;
timestamp=dt.Year * 100 + dt.Month;
timestamp=timestamp*100+dt.Day;
timestamp=timestamp*100+dt.Hour;
timestamp=timestamp*100+dt.Minute;
timestamp=timestamp*100+round(dt.Second);

