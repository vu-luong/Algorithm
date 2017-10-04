

data = load('pca.txt');
disp(data);


[X_norm, mu, sigma] = featureNormalize(data);
x = 1/11 * X_norm' * X_norm