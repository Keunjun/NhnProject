import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.net.URL;

String readUrl(String urlString) throws Exception
{
  BufferedReader reader = null;
  try
  {
    URL url = new URL (urlString);
    reader = new BufferedReader (new InputStreamReader (url.openStream(),"UTF-8"));
    StringBuffer buffer = new StringBuffer ();
    int read;
    String chars = null;
    while ( (chars = reader.readLine()) != null)
      buffer.append (chars);

    return buffer.toString ();
  }
  finally
  {
    if (reader != null)
      reader.close ();
  }
}

class Download extends Thread
{
  Download ()
  {
  }

  void start ()
  {
    super.start ();
  }

  void run ()
  {
    console.prints("Initializing.....");

    int i=0;
    JSONArray job = null;
    JSONObject jj = null;
    SimpleDateFormat formatt = new SimpleDateFormat ( "yyyy-MM-dd'T'hh:mm:ss'Z'", Locale.ENGLISH );
    ParsePosition pos = new ParsePosition ( 0 );
    Date dt = null;
    Date st = null;
    while ( true )
    {
      try
      {
        jj = new JSONObject (readUrl ("https://api.github.com/repos/"+id+"/"+repo));
        break ;
      }
      catch (Exception e)
      {
        continue ;
      }
    }
    Date en = formatt.parse ( jj.getString("created_at"), pos );

    console.prints("Commit Download Start \t\t Repos create at " + formatt.format (en));
    while (true)
    {
      if (job == null)
      {
        while ( true )
        {
          try
          {
            job = new JSONArray (readUrl ("https://api.github.com/repos/"+id+"/"+repo+"/commits?access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def"));
            break ;
          }
          catch (Exception e)
          {
            println ("error1");
            continue ;
          }
        }
        pos = new ParsePosition ( 0 );
        st = formatt.parse ( job.getJSONObject(0).getJSONObject("commit").getJSONObject("committer").getString("date"), pos );
      }
      else
      {
        while ( true )
        {
          try
          {
            job = new JSONArray (readUrl ("https://api.github.com/repos/"+id+"/"+repo+"/commits?until=" + formatt.format(dt) + "&access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def"));
            break ;
          }
          catch (Exception e)
          {
            println ("error2");
            continue ;
          }
        }
      }
      pos = new ParsePosition ( 0 );
      dt = formatt.parse ( job.getJSONObject(job.length()-1).getJSONObject("commit").getJSONObject("committer").getString("date"), pos );
      dt.setTime (dt.getTime () - 1000);

      double perc = (double)(st.getTime() - dt.getTime()) / (double)(st.getTime() - en.getTime()) * 100;
      console.prints(Integer.toString((int)perc)+"% :: " + "# : "+Integer.toString(i) + " \t\t " + job.getJSONObject(job.length()-1).getJSONObject("commit").getJSONObject("committer").getString("date") + " ~ " + job.getJSONObject(0).getJSONObject("commit").getJSONObject("committer").getString("date"));

      int j;
      int job_size = job.length ();
      for ( j = 0 ; j < job_size ; j ++ )
      {
        console.prints("    ("+Integer.toString(j+1)+"/"+Integer.toString(job_size)+") ----- "+job.getJSONObject(j).getString("sha"));
        if ( job.getJSONObject(j).getString("url") != "" )
        {
          while ( true )
          {
            try
            {
              cominfo.add_data (new JSONObject (readUrl (job.getJSONObject(j).getString("url")+"?access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def")));
              break ;
            }
            catch ( Exception e )
            {
              println ("error3 : " + job.getJSONObject(j).getString("url"));
              continue ;
            }
          }
        }
      }

      if (job.length () < 30)
      {
        console.prints("Download End");
        break;
      }
      i++;
    }
  }

  void quit()
  {
    interrupt();
  }
}

