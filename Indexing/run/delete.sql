
-- Remove a source (e.g. before re-indexing):

select id, codificator from sources where codificator='x';

delete from crossforms where source=x;
delete from lr_contexts where source=x;

delete from lr_positions where
  (not exists (select * from crossforms where crossforms.id=lr_positions.crossform))
  and
  (not exists (select * from lr_contexts where lr_contexts.id=lr_positions.context));

-- Garbage collector:

delete from crossforms where
  (not exists (select * from wordforms where wordforms.id=crossforms.wordform));

delete from wordforms where
  (not exists (select * from crossforms where crossforms.wordform=wordforms.id));
