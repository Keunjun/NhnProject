package github;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.net.URL;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class Download_logfiles {
	/**
	 * @param args
	 */
	private static String readUrl(String urlString) throws Exception {
		BufferedReader reader = null;
		try {
			URL url = new URL(urlString);
			reader = new BufferedReader(new InputStreamReader(url.openStream()));
			StringBuffer buffer = new StringBuffer();
			int read;
			char[] chars = new char[1024];
			while ((read = reader.read(chars)) != -1)
				buffer.append(chars, 0, read);

			return buffer.toString();
		} finally {
			if (reader != null)
				reader.close();
		}
	}

	public static void main(String[] args) {/*
		try {
			int i = 0;
			JSONArray job = null;
			while (true) {
				if (job == null) {
					job = JSONArray
							.fromObject(readUrl("https://api.github.com/repos/github/hubot/commits?access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def"));
				} else {
					job = JSONArray
							.fromObject(readUrl("https://api.github.com/repos/github/hubot/commits?until="
									+ job.getJSONObject(29)
											.getJSONObject("commit")
											.getJSONObject("committer")
											.getString("date")
									+ "&access_token=e8c4f454ccda7e78f5c9251517bba11f4fa91def"));
				}
				FileWriter file = new FileWriter("test" + Integer.toString(i)
						+ ".json");
				file.write(job.toString());
				file.flush();
				file.close();
				if (job.size() < 30) {
					System.out.println(job.size());
					break;
				}
				i++;
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		int i , j ;
		
		JSONObject test = new JSONObject();

		test.put("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz", "c");
		for ( i = 0 ; i < 50000000 ; i ++ )
		{
				test.put("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzza", "b");
		}
		
		System.out.print("start");
		for(i = 0 ; i < 100 ; i ++ )
		{
			System.out.print(test.getString("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzza"));
		}
	}
}
