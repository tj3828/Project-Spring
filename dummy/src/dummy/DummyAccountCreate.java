package dummy;

public class DummyAccountCreate {
	public static void main(String[] args) {
		
		String[] gender = {"'M'","'G'"};
		String[] profile = {"'duck1.png'","'duck2.png'","'duck3.png'","'dog1.png'","'dog2.png'","'dog3.png'","'peach1.png'","'peach2.png'","'peach3.png'"};
				
		for(int i=4001; i<=4500; i++) {
			int profile_randomNum = (int)(Math.random() * 9);
			int gender_randomNum = (int)(Math.random() * 2);
			
			String s = "'test";
			s += i+"'";
				
			System.out.println("insert into account values(" + s + "," + s + "," + s + "," + s + ",'tj3828@naver.com','010-4048-9352','서울 광진구 자양동','123'," + gender[gender_randomNum] + "," + profile[profile_randomNum] + ");");
		}
	}
}
