"
I represent Pharo Image create sub-command invoked from cmd line of Pharo Launcher. My responsibility is to create new local images within Pharo launcher based on specified template. 

I declare: 
- mandatory positional with existing image template name, based on new image is created
- optional flag for specifying new image name (other than default)

I execute:
- create new local image based on specified image template name with new name specified as flag
"
Class {
	#name : #PhLImageCreateCliCommand,
	#superclass : #PhLImageCliCommand,
	#category : #'PharoLauncher-CLI'
}

{ #category : #'command line' }
PhLImageCreateCliCommand class >> asCliCommand [
	^ self newLauncherCommand: #create 
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdDescription [

	^ 'Downloads and creates new image on local computer from remote site based on template name.'
]

{ #category : #'command line - arguments' }
PhLImageCreateCliCommand class >> launcherCmdFlags [

	^ {(ClapFlag id: #templateCategory)
				description: 'Allows to use a template categroy to search the target template ';
				meaning: [  :arg :app | (arg at: #templateCategoryName) word ];
				implicitMeaning: [  :arg :app | 'Official distributions'. ];
				add: ((ClapPositional id: #templateCategoryName)
					description: 'Name of the template category variable.';
					meaning: [ :pos | pos word asSymbol halt. ];
					implicitMeaning: [  :arg :app | app halt. ])}
					
			
]

{ #category : #'command line' }
PhLImageCreateCliCommand class >> launcherCmdPositionals [

	^ {
		((ClapPositional id: #templateName)
				description: 'Template which will be used to create the image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | app  ];
					yourself).
		((ClapPositional id: #newImageName)
				description: 'New image.';
					meaning: [ :pos | pos  asString ];
					implicitMeaning: [ :arg :app | app  ];
					yourself)	
	}
]

{ #category : #accessing }
PhLImageCreateCliCommand >> createImage: aTemplateName to:newImageName [
    [^ self imageRepository extractTemplate: (self findTheTemplate: aTemplateName) to: newImageName]
	on: NotFound 
	do: [ self errorStream nextPutAll:'cant find the template, please check the template name or category if you are using the category subcommand. You can check that with the template commands';
		cr. ] 
]

{ #category : #'command execution' }
PhLImageCreateCliCommand >> execute [
   self createImage: self templateName to: self imageName
]

{ #category : #'as yet unclassified' }
PhLImageCreateCliCommand >> findTheTemplate: aTemplateName [
	| templateCategory templateRepository |
	templateCategory := self templateCategory.
	templateRepository := self templateRepository: templateCategory.
   ^ templateRepository templatesAndGroups detect: [ :aTemplate | aTemplate name = aTemplateName ].
	
]

{ #category : #accessing }
PhLImageCreateCliCommand >> imageName [ 
   ^ (arguments at: #newImageName) word
]

{ #category : #'as yet unclassified' }
PhLImageCreateCliCommand >> officialTemplateRepository [
	| listTemplatesAvailableForDownload |
	listTemplatesAvailableForDownload := PhLTemplateGroupRepository
		default roots.
	listTemplatesAvailableForDownload := listTemplatesAvailableForDownload
		detect: [ :aGroup | aGroup name = self defaultTemplateCategory ].
	^ listTemplatesAvailableForDownload
]

{ #category : #'as yet unclassified' }
PhLImageCreateCliCommand >> templateCategory [
  ^ (arguments at: #templateCategory) value: self
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateCategoryName [ 
   ^ (arguments at: #templateCategoryName) word
]

{ #category : #accessing }
PhLImageCreateCliCommand >> templateName [ 
  ^ (arguments at: #templateName) word


]

{ #category : #'as yet unclassified' }
PhLImageCreateCliCommand >> templateRepository: aTemplateCategoryName [
	| listTemplatesCategories |
	listTemplatesCategories := self templateRepository roots.
	listTemplatesCategories := listTemplatesCategories
		detect: [ :aGroup | aGroup name = aTemplateCategoryName ].
	^ listTemplatesCategories
]