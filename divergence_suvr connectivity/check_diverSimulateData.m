% 1. Load atlas (AAL2 upsampled version)
atlas_path = which('upsampled_AAL2.nii');           % should be in BRAPH 2 path or your working directory
atlas_info = niftiinfo(atlas_path);
atlas_data = niftiread(atlas_path);

% Show all unique integer labels present in the atlas
unique_labels = unique(atlas_data(:));
unique_labels = unique_labels(unique_labels > 0);   % exclude background (0)
% fprintf('Unique region labels in atlas (excluding 0):\n');
% disp(unique_labels');
% 2. Load one example PET image (from your simulated data)
pet_file = fullfile('Example data Nifti diverse SUVR', 'Group2', 'Group2_subject_9', 'Group2_subject_9_PET.nii');
brain_pet = niftiread(pet_file);
region_idx = 2101;
% 3. Extract voxels belonging to region 2001
mask = (atlas_data == region_idx);
pet = brain_pet(mask);

% Remove zeros / background if desired (common in PET)
pet = pet(pet > 0);

% 4. Plot histogram
figure('Color','w');
hist(double(pet),60);
title(fprintf('PDF of PET values in region %d – Subject Group1\_9', region_idx));
xlabel('PET intensity value');
ylabel('Probability density');
grid on;
set(gca, 'FontSize', 14);

% Basic statistics printed to command window
fprintf('\nRegion %d statistics (Group1_subject_9):\n',region_idx);
fprintf('  Number of voxels: %d\n', nnz(mask));
fprintf('  Number of non-zero voxels: %d\n', length(pet));
fprintf('  Mean:   %.3f\n', mean(pet));
fprintf('  Std:    %.3f\n', std(double(pet)));
fprintf('  Median: %.3f\n', median(pet));

%%
subt_div2 = gr2_div.get('IT',1).get('A');
figure
imagesc(subt_div2{1})
title('div G2')
figure
subt_dist2 = Con_gr2_Distance.get('SUB_DICT').get('IT',1).get('CON');
imagesc(subt_dist2)
title('dist G2')

subt_div1 = gr1_div.get('IT',1).get('A');
figure
imagesc(subt_div1{1})
title('div G1')
figure
subt_dist1 = Con_gr1_Distance.get('SUB_DICT').get('IT',1).get('CON');
imagesc(subt_dist1)
title('dist G1')