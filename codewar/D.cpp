#include <map>
#include <set>
#include <cmath>
#include <cstdio>
#include <vector>
#include <string>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <algorithm>

using namespace std;
// consts here

// variables here
map<string, int> point, goalDiff, goals, numMatches;
set<string> teams;
string t[4];
int p[4], diff[4], g[4];
int id[4];

bool comp(int id1, int id2) {
	if (p[id1] == p[id2]) {
		if (diff[id1] == diff[id2]) {
			if (g[id1] == g[id2]) {
				return t[id1].compare(t[id2]) > 0;
			} else {
				return g[id1] > g[id2];
			}
		} else {
			return diff[id1] > diff[id2];
		}
	} else {
		return p[id1] > p[id2];
	}

}


void addTeam(string team) {
	if (teams.find(team) == teams.end())  {
		teams.insert(team);
		point.insert(make_pair(team, 0));
		goalDiff.insert(make_pair(team, 0));
		goals.insert(make_pair(team, 0));
		numMatches.insert(make_pair(team, 0));
	}
}

void init(){
	for (int i = 0; i < 5; i++) {
		string t1, t2, res;
		cin >> t1 >> t2 >> res;
		addTeam(t1); addTeam(t2);
		int goal1 = res[0] - '0';
		int goal2 = res[2] - '0';
		
		if (goal1 > goal2) {
			point.find(t1)->second += 3;
		} else if (goal1 < goal2) {
			point.find(t2)->second += 3;
		} else {
			point.find(t1)->second += 1;
			point.find(t2)->second += 1;
		}

		goalDiff.find(t1)->second += (goal1 - goal2);
		goalDiff.find(t2)->second += (goal2 - goal1);
		goals.find(t1)->second += goal1;
		goals.find(t2)->second += goal2;
		numMatches.find(t1)->second += 1;
		numMatches.find(t2)->second += 1;
	}
}

bool checkWin() {

	//cout << "AFTER LAST MATCH \n"	;
	int i = 0;
	for (set<string>::iterator itr = teams.begin(); itr != teams.end(); ++itr) {
		string team = *itr;
		t[i] = team;
		p[i] = point.find(team)->second;
		diff[i] = goalDiff.find(team)->second;;
		g[i] = goals.find(team)->second;
		id[i] = i;
		//cout << t[i] << " " << p[i] << " " << diff[i] << " " << g[i] << endl;
		i++;
	}

	//cout << "after sort:" << endl;

	sort(id, id + 4, comp);
	

	return (t[id[0]] == "VIETNAM" || t[id[1]] == "VIETNAM");
}

void solve() {
	string other;
	string our = "VIETNAM";
	for (set<string>::iterator itr = teams.begin(); itr != teams.end(); ++itr) {
		string team = *itr;
		if (team != our && numMatches.find(team)->second < 3) {
			other = team;
		}
	}

	for (int diff = 1; diff <= 9; diff++) {
		for (int n = 0; n <= 9 - diff; n++) {
			int m = n + diff;

			//cout << endl;
			//cout << "CHECKING " << m << ":" << n << endl;
			// check win m:n
			goalDiff.find(our)->second += diff;
			goalDiff.find(other)->second -= diff;
			goals.find(our)->second += m;
			goals.find(other)->second += n;
			point.find(our)->second += 3;

			// TODO - check if VIETNAM can be at 1st or 2nd
			if (checkWin()) {
				cout << m << ":" << n;
				return;
			}
			// restore 
			goalDiff.find(our)->second -= diff;
			goalDiff.find(other)->second += diff;
			goals.find(our)->second -= m;
			goals.find(other)->second -= n;
			point.find(our)->second -= 3;
		}
	}

	cout << "IMPOSSIBLE";
}
 
int main(){
	init();
	solve();
//	return 0;
}
