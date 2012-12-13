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
    reader = new BufferedReader (new InputStreamReader (url.openStream()));
    StringBuffer buffer = new StringBuffer ();
    int read;
    char[] chars = new char[1024];
    while ( (read = reader.read (chars)) != -1)
      buffer.append (chars, 0, read);

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
    try
    {
      int i=0;
      JSONArray job = null;
      JSONObject jj = null;
      jj = new JSONObject (readUrl ("https://api.github.com/repos/github/hubot"));
      SimpleDateFormat formatt = new SimpleDateFormat ( "yyyy-MM-dd'T'hh:mm:ss'Z'", Locale.ENGLISH );
      ParsePosition pos = new ParsePosition ( 0 );
      Date en = formatt.parse ( jj.getString("created_at"), pos ), dt = null;
      Date st = null;

      console.prints("Commit Download Start \t\t Repos create at " + formatt.format (en));
      while (true)
      {
        if (job == null)
        {
          job = new JSONArray (readUrl ("https://api.github.com/repos/github/hubot/commits?access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def"));
          pos = new ParsePosition ( 0 );
          st = formatt.parse ( job.getJSONObject(0).getJSONObject("commit").getJSONObject("committer").getString("date"), pos );
        }
        else
        {
          job = new JSONArray (readUrl ("https://api.github.com/repos/github/hubot/commits?until=" + formatt.format(dt) + "&access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def"));
        }
        pos = new ParsePosition ( 0 );
        dt = formatt.parse ( job.getJSONObject(job.length()-1).getJSONObject("commit").getJSONObject("committer").getString("date"), pos );
        dt.setTime (dt.getTime () - 1000);

        double perc = (double)(st.getTime() - dt.getTime()) / (double)(st.getTime() - en.getTime()) * 100;
        console.prints(Integer.toString((int)perc)+"% :: " + "# : "+Integer.toString(i) + " \t\t " + job.getJSONObject(job.length()-1).getJSONObject("commit").getJSONObject("committer").getString("date") + " ~ " + job.getJSONObject(0).getJSONObject("commit").getJSONObject("committer").getString("date"));
        cominfo.add_data(job);
        if (job.length () < 30)
        {
          console.prints("Download End");
          break;
        }
        i++;
      }
      
      cominfo.calc();
    }
    catch (Exception e)
    {
    }
  }

  void quit()
  {
    interrupt();
  }
}

