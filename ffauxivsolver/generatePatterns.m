close all; clear; clc;

% Patterns manually created based on
% https://docs.google.com/spreadsheets/d/1mUyCzlzDmdXMwaSTUgWXtEA45oJNn-iB4_bVM43zf58/edit?gid=1940464160#gid=1940464160
foxProbability = 0.19;

%% Import patterns
A_patterns = readmatrix("A.csv");
A_names = "A↑" + (1:(size(A_patterns, 1)/6))' + cellfun(@(x) string(char(x)), num2cell('a'+(1:(size(A_patterns, 2)/6))-1));
A_patterns = mat2cell(A_patterns, repmat(6, size(A_patterns, 1)/6, 1), repmat(6, size(A_patterns, 2)/6, 1));
A_patterns = cell2mat(reshape(A_patterns, 1, 1, []));
A_names = reshape(A_names, 1, 1, []);

B_patterns = readmatrix("B.csv");
B_names = "B↑" + (1:(size(B_patterns, 1)/6))' + cellfun(@(x) string(char(x)), num2cell('a'+(1:(size(B_patterns, 2)/6))-1));
B_patterns = mat2cell(B_patterns, repmat(6, size(B_patterns, 1)/6, 1), repmat(6, size(B_patterns, 2)/6, 1));
B_patterns = cell2mat(reshape(B_patterns, 1, 1, []));
B_names = reshape(B_names, 1, 1, []);

C_patterns = readmatrix("C.csv");
C_names = "C↑" + (1:(size(C_patterns, 1)/6))' + cellfun(@(x) string(char(x)), num2cell('a'+(1:(size(C_patterns, 2)/6))-1));
C_patterns = mat2cell(C_patterns, repmat(6, size(C_patterns, 1)/6, 1), repmat(6, size(C_patterns, 2)/6, 1));
C_patterns = cell2mat(reshape(C_patterns, 1, 1, []));
C_names = reshape(C_names, 1, 1, []);

D_patterns = readmatrix("D.csv");
D_names = "D↑" + (1:(size(D_patterns, 1)/6))' + cellfun(@(x) string(char(x)), num2cell('a'+(1:(size(D_patterns, 2)/6))-1));
D_patterns = mat2cell(D_patterns, repmat(6, size(D_patterns, 1)/6, 1), repmat(6, size(D_patterns, 2)/6, 1));
D_patterns = cell2mat(reshape(D_patterns, 1, 1, []));
D_names = reshape(D_names, 1, 1, []);

patterns = cat(3, A_patterns, B_patterns, C_patterns, D_patterns);
names = cat(3, A_names, B_names, C_names, D_names);
empty_filter = all(isnan(patterns), [1 2]);
patterns(:, :, empty_filter) = [];
names(:, :, empty_filter) = [];

%% Validate patterns
block_check = all(sum(patterns == 0, [1 2]) == 5);
blank_check = all(sum(patterns == 1, [1 2]) == 17);
baux_check = all(sum(patterns == 2, [1 2]) == 4);
sword_check = all(sum(patterns == 3, [1 2]) == 6);
faux_check = all(sum(patterns == 4, [1 2]) == 4);
block_check_A = sum(all(A_patterns == 0 | isnan(A_patterns), 3), [1 2]) == 5;
block_check_B = sum(all(B_patterns == 0 | isnan(B_patterns), 3), [1 2]) == 5;
block_check_C = sum(all(C_patterns == 0 | isnan(C_patterns), 3), [1 2]) == 5;
block_check_D = sum(all(D_patterns == 0 | isnan(D_patterns), 3), [1 2]) == 5;

if ~all([block_check blank_check baux_check sword_check faux_check block_check_A block_check_B block_check_C block_check_D])
    "problem"
end

%% Seperate faux instances
offset_len = length(names);
patterns = repmat(patterns, 1, 1, 5);
names = repmat(names, 1, 1, 5);

for iP = 1:offset_len
    pattern = patterns(:, :, iP);
    name = names(iP);

    iFaux = find(pattern == 4);

    pattern0 = pattern;
    pattern0(iFaux) = 1;

    pattern1 = pattern0;
    pattern2 = pattern0;
    pattern3 = pattern0;
    pattern4 = pattern0;
    
    pattern1(iFaux(1)) = 4;
    pattern2(iFaux(2)) = 4;
    pattern3(iFaux(3)) = 4;
    pattern4(iFaux(4)) = 4;

    patterns(:, :, iP) = pattern0;
    patterns(:, :, iP+offset_len*1) = pattern1;
    patterns(:, :, iP+offset_len*2) = pattern2;
    patterns(:, :, iP+offset_len*3) = pattern3;
    patterns(:, :, iP+offset_len*4) = pattern4;

    names(iP) = name + 0;
    names(iP+offset_len*1) = name + 1;
    names(iP+offset_len*2) = name + 2;
    names(iP+offset_len*3) = name + 3;
    names(iP+offset_len*4) = name + 4;
end

%% Rotate patterns
patterns = cat(3, patterns, rot90(patterns, -1), rot90(patterns, -2), rot90(patterns, -3));
names = cat(3, names, regexprep(names, "↑", "→"), regexprep(names, "↑", "↓"), regexprep(names, "↑", "←"));

%% Alphabetize
[names, iS] = sort(names);
patterns = patterns(:, :, iS);
chances = ones(size(names));
foxType = cellfun(@(x) x(5), {names{:}});
chances(foxType=='0') = (1-foxProbability);
chances(foxType~='0') = (foxProbability/4);
chances = chances/sum(chances);

%% Create metadata
metadata = strings(size(patterns));
metadata(patterns == 0) = "x";
metadata(patterns == 1) = "m";
metadata(patterns == 2) = repmat(["b1" "b2" "b3" "b4"], 1, length(names));
verticalSwords = sum(any(patterns == 3, 1), 2) == 2;
metadata(patterns == 3 & verticalSwords) = repmat(["s1v" "s2v" "s3v" "s4v" "s5v" "s6v"], 1, sum(verticalSwords));
metadata(patterns == 3 & ~verticalSwords) = repmat(["s1h" "s2h" "s3h" "s4h" "s5h" "s6h"], 1, sum(~verticalSwords));
metadata(patterns == 4) = "f";

%% Test
iP = randi(length(names));
patterns(:, :, iP)
names(iP)

save patterns patterns names chances metadata