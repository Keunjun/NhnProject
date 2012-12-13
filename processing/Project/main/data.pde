class Data
{
  class Commit
  {
    String name;
    String message;
    Date when;

    String[] filename;
    int addition;
    int deletion;

    int delta_complexity;
    int delta_line;

    Commit (JSONObject info, String[] files)
    {
      name = info.getJSONObject("commit").getJSONObject("author").getString("name");
      message = info.getJSONObject("commit").getString("message");
      SimpleDateFormat formatt = new SimpleDateFormat ( "yyyy-MM-dd'T'hh:mm:ss'Z'", Locale.ENGLISH );
      ParsePosition pos = new ParsePosition ( 0 );
      when = formatt.parse ( info.getJSONObject("commit").getJSONObject("committer").getString("date"), pos );
      int d = info.getJSONObject("state").getInt("deletions");
      if (d>0) deletion+=d;
      int a = info.getJSONObject("state").getInt("additions");
      if (a>0) addition+=a;

      JSONArray f = info.getJSONArray("files");
      int size = f.length (), i;
      for (i=0 ; i<size ; i++)
      {
        JSONObject temp = f.getJSONObject(i);
        String fn  = temp.getString("filename");

        int line = getline (files [i]);

        if (temp.getString ("status") == "added")
        {
          JSONObject ftemp = new JSONObject ();
          ftemp.put ("line", line);
          file_name.put (fn, ftemp);
          delta_line = line;
        }
        else
        {
          if (temp.getString ("status") == "removed")
          {
            file_name.remove (fn);
            delta_line = (-1) * line;
          }
          else
          {
            delta_line = line-file_name.getJSONObject(fn).getInt("line");
            file_name.remove (fn);
            JSONObject ftemp = new JSONObject ();
            ftemp.put ("line", line);
            file_name.put (fn, ftemp);
          }
        }
      }
    }

    int getline (String con)
    {
      int i, count=0;

      for (i=0 ; i<con.length() ; i++)
      {
        if (con.charAt(i) == '\n')
          count++;
      }

      return count;
    }

    JSONObject makejson ()
    {
      return null;
    }
  }

  Commit[] a = new Commit[100000];
  boolean clac_now = false;

  //JSONObject file_sha;
  JSONObject file_name;
  JSONObject[] raw_commit = new JSONObject[100000];
  int raw_count;

  Data ()
  {
    file_name = new JSONObject ();
    raw_count = 0;
  }

  void add_data (JSONArray arr)
  {
    int size, i;
    size = arr.length () ;
    for (i=0 ; i<size ; i++)
    {
      raw_commit[raw_count++] = arr.getJSONObject(i);
    }
  }
  
  void calc ()
  {
  }
}

