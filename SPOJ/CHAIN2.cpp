//
//  main.cpp
//  CHAIN2
//
//  Created by luong anh vu on 6/27/16.
//  Copyright © 2016 luong anh vu. All rights reserved.
//
#include<stdio.h>
#include<string.h>
#include<math.h>
#include<iostream>
#include<string>
#include<stdlib.h>
#include<vector>
#include<stack>
#include<queue>
#include<set>
#include<map>
#include<algorithm>
#define CHAR_TO_INDEX(c) ((int)c - (int)'a')

using namespace std;

class TrieNode {
public:
    TrieNode *c[26];
    int cnt, f;
};

int n;
string s;
TrieNode *root;

void add(TrieNode *&p) {
    p = new TrieNode();
    p->cnt = 0;
    for (int i = 0; i < 26; i++) {
        p->c[i] = NULL;
    }
}

void insert(TrieNode *root, string key) {
    TrieNode *r = root;
    
    for (int i = 0; i < key.length(); i++) {
        int id = CHAR_TO_INDEX(key[i]);
        if (!r->c[id]) add(r->c[id]);
        r = r->c[id];
    }
    r->cnt += 1;
}

bool search(TrieNode *root, string key) {
    TrieNode *r = root;
    for (int i = 0; i < key.length(); i++) {
        int id = CHAR_TO_INDEX(key[i]);
        if (!r->c[id]) return false;
        r = r->c[id];
    }
    
    return r->cnt > 0;
}

void dfs(TrieNode *&a) {
    a->f = 0;
    
    for (int i = 0; i < 26; i++) {
        if (a->c[i]) {
            dfs(a->c[i]);
            a->f = max(a->f, a->c[i]->f);
        }
    }
    
    a->f += a->cnt;
}

int main() {
//    freopen("input.txt", "r", stdin);
    cin >> n;
    
    add(root);
    
    for (int i = 1; i <= n; i++) {
        cin >> s;
        insert(root, s);
    }
    
    dfs(root);
    
    cout << root->f;
}